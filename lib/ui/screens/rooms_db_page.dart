import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/chat_db_pages.dart';
import 'package:flutter_mqtt/ui/screens/chat_ui_page.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';

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
        actions: [IconButton(onPressed: _onLogout, icon: Icon(Icons.logout))],
      ),
      body: StreamBuilder<List<ContactChat>>(
          stream: AppData.instance()!.contactsHandler.getContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatUIDBPage(room: room)),
    );
  }

  _onLogout() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'No'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
              AppData.instance()!.deleteAllAndDisconnect();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
