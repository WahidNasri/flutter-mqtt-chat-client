import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';

class MediaViewerPage extends StatelessWidget {
  final String roomId;
  final String messageId;
  const MediaViewerPage(
      {Key? key, required this.roomId, required this.messageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Viewer"),
      ),
      body: StreamBuilder<List<ChatMessage>>(
          stream: AppData.instance()!
              .messagesHandler
              .getMediaMessagesByRoomId(roomId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              var messages = snapshot.data;
              final PageController controller = PageController(
                  initialPage: messages!
                      .indexWhere((element) => element.id == messageId));
              return PageView(
                  controller: controller,
                  children: messages
                      .map((msg) => Image.network(msg.attachment ?? ""))
                      .toList());
            } else {
              return Text("Loading...");
            }
          }),
    );
  }
}
