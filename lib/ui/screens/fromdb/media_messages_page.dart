import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';
import 'package:flutter_mqtt/ui/viewers/media_viewer.dart';

class MediaMessagesPage extends StatelessWidget {
  final ContactChat contactChat;
  const MediaMessagesPage({Key? key, required this.contactChat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Messages"),
      ),
      body: StreamBuilder<List<ChatMessage>>(
          stream: AppData.instance()!
              .messagesHandler
              .getMediaMessagesByRoomId(contactChat.roomId),
          builder: (context, snapshot) {
            int count = snapshot.hasData ? snapshot.data!.length : 0;
            List<ChatMessage> data =
                snapshot.hasData ? snapshot.data! : List<ChatMessage>.empty();
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              children: data
                  .map((msg) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                            pageBuilder: (_, __, ___) => MediaViewerPage(
                                  roomId: contactChat.roomId,
                                  messageId: msg.id,
                              initMessage: msg,
                                )));

                      },
                      child: Hero(
                        tag: "image_" + msg.id,
                        child: msg.toGridItem(),
                      )))
                  .toList(),
            );
          }),
    );
  }
}
