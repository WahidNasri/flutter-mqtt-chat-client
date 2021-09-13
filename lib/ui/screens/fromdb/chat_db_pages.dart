import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';

class ChatUIDBPage extends StatefulWidget {
  final ContactChat contactChat;
  const ChatUIDBPage({Key? key, required this.contactChat}) : super(key: key);

  @override
  _ChatUIPageState createState() => _ChatUIPageState();
}

class _ChatUIPageState extends State<ChatUIDBPage> {
  bool isTyping = false;
  final subscriptions = List<StreamSubscription<dynamic>>.empty(growable: true);
  types.User? _user;

  @override
  void initState() {
    AppData.instance()!
        .usersHandler
        .getLocalUser()
        .then((dbuser) => {_user = dbuser!.toUiUser2()});

    var s2 =
        ChatApp.instance()!.messageReader.getTypingMessages().listen((event) {
      if (event.roomId == widget.contactChat.roomId &&
          event.fromId != _user!.id) {
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

    subscriptions.add(s2);
    super.initState();
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
      String path = result.files.single.path;
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.ChatImage,
          fileLocalPath: path,
          room: widget.contactChat.roomId);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      ChatApp.instance()!.messageSender.sendFileChatMessage(
          type: MessageType.ChatImage,
          fileLocalPath: result.path,
          room: widget.contactChat.roomId);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

/*
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
*/
  void _handleSendPressed(types.PartialText message) {
    ChatMessage nm = ChatMessage(
        id: const Uuid().v4(),
        type: MessageType.ChatText,
        text: message.text,
        roomId: widget.contactChat.roomId,
        fromId: _user!.id,
        sendTime: DateTime.now().millisecondsSinceEpoch,
        fromName: _user!.firstName);
    ChatApp.instance()!
        .messageSender
        .sendChatMessage(nm, widget.contactChat.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.contactChat.firstName +
                  " " +
                  widget.contactChat.lastName),
              Visibility(
                child: Text(
                  "Typing...",
                  style: TextStyle(fontSize: 11),
                ),
                visible: isTyping,
              )
            ],
          )),
      body: StreamBuilder<List<DbMessage>>(
          stream: AppData.instance()!
              .messagesHandler
              .getMessagesByRoomId(widget.contactChat.roomId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              var data = snapshot.data!.map((e) => e.toUiMessage()).toList();
              return Chat(
                messages: data,
                disableImageGallery: true,
                onAttachmentPressed: _handleAtachmentPressed,
                onMessageTap: _handleMessageTap,
                //onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                onTextChanged: _handleTextChanged,
                showUserNames: true,
                showUserAvatars: true,

                user: _user!,
              );
            }
            return Text("Loading...");
          }),
    );
  }

  void _handleTextChanged(String text) {
    if (text.length > 0 && text.length % 3 == 0) {
      ChatApp.instance()!
          .eventsSender
          .sendIsTyping(true, widget.contactChat.roomId);
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
