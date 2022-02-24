import 'dart:math';

import 'package:example/database/models/room.dart';
import 'package:example/database/models/user.dart';
import 'package:example/proviers/chat_providers.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/extensions/messages_extensions.dart';
import 'package:example/ui/widgets/typing_indicator_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_mqtt/chat_app.dart';
import 'package:flutter_chat_mqtt/models/chat_message.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

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
            TypingIndicatorText(roomId: widget.room.id, isGroup: widget.room.isGroup, currentUserId: user!.id)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(foregroundImage: NetworkImage(widget.room.avatar ?? '')),
          )
        ],
      ),
      body: ref.watch(messagesProvider(widget.room.id)).when(
          data: (messages) => Chat(
                messages: messages
                    .map((m) => m.toUiMessage(
                        userId: m.fromId!, name: m.fromName ?? ""))
                    .toList().reversed.toList(),
                onTextChanged: _handleTextChanged,
                onAttachmentPressed: () {},
                onMessageTap: (c, m) {},
                onPreviewDataFetched: (tm, p) {},
                onSendPressed: _handleSendPressed,
                showUserAvatars: widget.room.isGroup,
                onMessageVisibilityChanged: (message, visible){
                  if(visible && message.status != types.Status.seen){
                    ChatApp.instance()!.eventsSender.sendChatMarker(message.id, ChatMarker.displayed, widget.room.id);
                  }
                },
                user: types.User(id: user.id, firstName: user.name, imageUrl: user.avatar),
              ),
          error: (e, s) => Text(e.toString()),
          loading: () => Text("Loading...")),
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
  void _handleTextChanged(String text){
    if(text.length % 3 == 0){
      ChatApp.instance()!.eventsSender.sendIsTyping(true, widget.room.id);
      lastTypingSentTime = DateTime.now();

      //if nothing changed in 3 seconds send is typing false
      Future.delayed(const Duration(seconds: 3), (){
        if(DateTime.now().difference(lastTypingSentTime!).inSeconds > 2){
          ChatApp.instance()!.eventsSender.sendIsTyping(false, widget.room.id);
        }
      });
    }
  }
}
