import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/live/chat_ui_page.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final List<ContactChat> cchats = List<ContactChat>.empty(growable: true);
  @override
  void initState() {
    ChatApp.instance()!.archiveHandler.getAllConversations().listen((contacts) {
      setState(() {
        cchats.addAll(contacts);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rooms"),
      ),
      body: ListView.builder(
          itemCount: cchats.length,
          itemBuilder: (context, position) {
            return InkWell(
              onTap: () {
                _openRoom(context, cchats[position].roomId);
              },
              child: ListTile(
                title: Text(cchats[position].firstName +
                    " " +
                    cchats[position].lastName),
                subtitle: Text("Room: " + cchats[position].roomId),
              ),
            );
          }),
    );
  }

  _openRoom(BuildContext context, String room) {
    ChatApp.instance()!.clientHandler.joinRoom(room);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatUIPage(room: room)),
    );
  }
}
