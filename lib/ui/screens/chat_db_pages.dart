import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:flutter_mqtt/db/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';

class ChatUIDBPage extends StatefulWidget {
  final String room;
  const ChatUIDBPage({Key? key, required this.room}) : super(key: key);

  @override
  _ChatUIPageState createState() => _ChatUIPageState();
}

class _ChatUIPageState extends State<ChatUIDBPage> {
  List<types.Message> _messages = [];
  bool isTyping = false;
  final subscriptions = List<StreamSubscription<dynamic>>.empty(growable: true);
  final _user = ChatApp.instance()!.clientHandler.getUser()!.toUiUser();

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void initState() {
    var s1 = AppData.instance()!.getMessagesByRoom(widget.room).listen((msgs) {
      //ignore message for other rooms

      //types.Message conv = msgs..toUiMessage();

      setState(() {
        //_insert(conv);
        _messages = msgs
            .where((m) => m.roomId == widget.room)
            .map((e) => e.toUiMessage())
            .toList();
      });
    });
    var s2 =
        ChatApp.instance()!.messageReader.getTypingMessages().listen((event) {
      if (event.roomId == widget.room) {
        setState(() {
          isTyping = event.isTyping;
        });
        Future.delayed(Duration(milliseconds: 3000), () {
          setState(() {
            isTyping = false;
          });
        });
      }
    });

    subscriptions.add(s1);
    subscriptions.add(s2);
    super.initState();
  }

  void _insert(types.Message msg) {
    var old = _messages.firstWhereOrNull((element) => element.id == msg.id);
    if (old != null) {
      _messages[_messages.indexOf(old)] = msg;
    } else {
      _messages.insert(0, msg);
    }
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path ?? ''),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path ?? '',
      );

      _addMessage(message);
      //TODO: handle file sending
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      //ChatApp.instance()!.messageSender.sendChatMessage(msg, widget.room);
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          uploadUrl: "URL",
          type: MessageType.ChatImage,
          fileLocalPath: result.path,
          fromId: ChatApp.instance()!.clientHandler.getUserId(),
          toId: widget.room,
          fromName: ChatApp.instance()!.clientHandler.getUserId(),
          room: widget.room);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    ChatMessage nm = ChatMessage(
        id: const Uuid().v4(),
        type: MessageType.ChatText,
        text: message.text,
        roomId: widget.room,
        fromId: _user.id,
        sendTime: DateTime.now().millisecondsSinceEpoch,
        fromName: _user.firstName);
    ChatApp.instance()!.messageSender.sendChatMessage(nm, widget.room);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.room),
          Visibility(
            child: Text(
              "Someone is Typing...",
              style: TextStyle(fontSize: 11),
            ),
            visible: isTyping,
          )
        ],
      )),
      body: Chat(
        messages: _messages,
        onAttachmentPressed: _handleAtachmentPressed,
        onMessageTap: _handleMessageTap,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        onTextChanged: _handleTextChanged,
        showUserNames: true,
        showUserAvatars: true,
        user: _user,
      ),
    );
  }

  void _handleTextChanged(String text) {
    if (text.length > 0 && text.length % 3 == 0) {
      ChatApp.instance()!.eventsSender.sendIsTyping(true, widget.room);
    }
  }

  @override
  void dispose() {
    subscriptions.forEach((element) {
      element.cancel();
    });
    super.dispose();
  }
}
