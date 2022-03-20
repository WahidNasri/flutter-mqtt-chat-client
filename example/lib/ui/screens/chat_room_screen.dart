import 'package:example/database/models/room.dart';
import 'package:example/proviers/chat_providers.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/extensions/messages_extensions.dart';
import 'package:example/ui/screens/profile_screen.dart';
import 'package:example/ui/widgets/room_avatar.dart';
import 'package:example/ui/widgets/typing_indicator_text.dart';
import 'package:example/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_mqchat/chat_app.dart';
import 'package:flutter_mqchat/models/chat_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final Room room;
  const ChatRoomScreen({Key? key, required this.room}) : super(key: key);

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  DateTime? lastTypingSentTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user;
    //FIXME: don't use user! here (user could be null)
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.room.name),
            TypingIndicatorText(
                roomId: widget.room.id,
                isGroup: widget.room.isGroup,
                currentUserId: user!.id)
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(room: widget.room),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                  tag: "avatar_" + widget.room.id,
                  child: RoomAvatar(room: widget.room)),
            ),
          )
        ],
      ),
      body: ref.watch(messagesProvider(widget.room.id)).when(
          data: (messages) => Chat(
                messages: messages
                    .map((m) => m.toUiMessage(
                        userId: m.fromId!, name: m.fromName ?? ""))
                    .toList()
                    .reversed
                    .toList(),
                onTextChanged: _handleTextChanged,
                onAttachmentPressed: _handleAtachmentPressed,
                onMessageTap: (c, m) {},
                onPreviewDataFetched: (tm, p) {},
                onSendPressed: _handleSendPressed,
                showUserAvatars: widget.room.isGroup,
                onMessageVisibilityChanged: (message, visible) {
                  if (visible &&
                      message.status != types.Status.seen &&
                      user.id != message.metadata!["fromId"]) {
                    ChatApp.instance()!.eventsSender.sendChatMarker(
                        message.id, ChatMarker.displayed, widget.room.id);
                  }
                },
                user: types.User(
                    id: user.id, firstName: user.name, imageUrl: user.avatar),
              ),
          error: (e, s) => Text(e.toString()),
          loading: () => const Text("Loading...")),
    );
  }

  void _handleSendPressed(types.PartialText text) {
    //TODO: better solution: insert it to db as status null then send all messages with null status
    ChatApp.instance()!.messageSender.sendChatMessage(
        ChatMessage(
            id: const Uuid().v4(),
            type: MessageType.chatText,
            text: text.text,
            roomId: widget.room.id,
            sendTime: DateTime.now().millisecondsSinceEpoch),
        widget.room.id);
  }

  void _handleTextChanged(String text) {
    if (text.length % 3 == 0) {
      ChatApp.instance()!.eventsSender.sendIsTyping(true, widget.room.id);
      lastTypingSentTime = DateTime.now();

      //if nothing changed in 3 seconds send is typing false
      Future.delayed(const Duration(seconds: 3), () {
        if (DateTime.now().difference(lastTypingSentTime!).inSeconds > 2) {
          ChatApp.instance()!.eventsSender.sendIsTyping(false, widget.room.id);
        }
      });
    }
  }

  void _handleAtachmentPressed() {
    showAdaptiveActionSheet(context: context, actions: [
      BottomSheetAction(
          title: const Text('Video'), onPressed: _handleVideoSelection),
      BottomSheetAction(
          title: const Text('Photo'), onPressed: _handleImageSelection),
      BottomSheetAction(
          title: const Text('File'), onPressed: _handleFileSelection),
      BottomSheetAction(
          title: const Text('Location'), onPressed: _handleLocationSelection),
    ]);
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.chatImage,
          fileLocalPath: result.files.single.path!,
          room: widget.room.id);
    }
  }

  void _handleLocationSelection() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              mapApiKey,
            )));

    // Handle the result in your way
    if (result.latLng != null) {
      ChatApp.instance()!.messageSender.sendLocationMessage(
          result.latLng!.longitude,
          result.latLng!.latitude,
          result.formattedAddress,
          widget.room.id);
    }
    debugPrint(result.toString());
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.chatImage,
          fileLocalPath: result.path,
          room: widget.room.id);
    }
  }

  void _handleVideoSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.chatVideo,
          fileLocalPath: result.path,
          room: widget.room.id);
    }
  }
}
