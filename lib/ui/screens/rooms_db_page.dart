import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/chat_db_pages.dart';
import 'package:flutter_mqtt/ui/screens/chat_ui_page.dart';

class RoomsDBPage extends StatefulWidget {
  RoomsDBPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsDBPage> {
  /*
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
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rooms"),
      ),
      body: StreamBuilder<List<ContactChat>>(
          stream: AppData.instance()!.getContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.data.toString());
            }
            if (snapshot.hasData) {
              var cchats = snapshot.data;
              return ListView.builder(
                  itemCount: cchats!.length,
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
                  });
            } else {
              return Text("Loading...");
            }
          }),
    );
  }

  _openRoom(BuildContext context, String room) {
    ChatApp.instance()!.clientHandler.joinRoom(room);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatUIDBPage(room: room)),
    );
  }
}
