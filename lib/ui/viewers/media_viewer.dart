import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';
import 'package:intl/intl.dart';

class MediaViewerPage extends StatefulWidget {
  final String roomId;
  final String messageId;
  final ChatMessage? initMessage;
  const MediaViewerPage(
      {Key? key,
      required this.roomId,
      required this.messageId,
      this.initMessage})
      : super(key: key);

  @override
  _MediaViewerPageState createState() => _MediaViewerPageState();
}

class _MediaViewerPageState extends State<MediaViewerPage> {
  String sendTime = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Column(
          children: [
            Text("Media Viewer"),
            Text(
              sendTime,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      body: Hero(
        tag: "image_" + widget.messageId,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: StreamBuilder<List<ChatMessage>>(
              stream: AppData.instance()!
                  .messagesHandler
                  .getMediaMessagesByRoomId(widget.roomId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  var messages = snapshot.data;

                  int initialPosition = messages!
                      .indexWhere((element) => element.id == widget.messageId);

                  final PageController controller =
                      PageController(initialPage: initialPosition);

                  return PageView(
                      controller: controller,
                      onPageChanged: (position) {
                        setState(() {
                          sendTime =
                              messages[position].formatDate('dd/MM/yyyy HH:mm');
                        });
                      },
                      children:
                          messages.map((msg) => msg.toPagerItem()).toList());
                } else {
                  return widget.initMessage != null
                      ? widget.initMessage!.toPagerItem()
                      : Text("Loading...");
                }
              }),
        ),
      ),
    );
  }
}
