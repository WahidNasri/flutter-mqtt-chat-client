import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/chat_db_pages.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/profile_page.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart'
    as cs;

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
        leading: StreamBuilder<DbUser?>(
            stream: AppData.instance()!.usersHandler.getLocalUserAsync(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return InkWell(
                  onTap: _openProfile,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(snapshot.data!.avatar ??
                          "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),

                    ),
                  ),
                );
              }
              return SizedBox(height: 0, width: 0,);
            }),
        title: Column(
          children: [
            Text("Flutter MQTT Chat"),
            StreamBuilder<cs.ConnectionState>(
                stream:
                    ChatApp.instance()!.clientHandler.connectionStateStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    );
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data.toString().split(".")[1],
                        style: TextStyle(fontSize: 12));
                  }
                  return Text("Loading Connection State...",
                      style: TextStyle(fontSize: 15));
                })
          ],
        ),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          // A stream builder to indicate that the user info is not received yet from the broker
          StreamBuilder(
              stream: AppData.instance()!.usersHandler.getLocalUserAsync(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Text("Waiting for User info...");
              }),
          Expanded(
            child: StreamBuilder<List<ContactChat>>(
                stream: AppData.instance()!.contactsHandler.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    var chats = snapshot.data;
                    return ListView.builder(
                        itemCount: chats!.length,
                        itemBuilder: (context, position) {
                          return InkWell(
                            onTap: () {
                              _openRoom(context, chats[position]);
                            },
                            child: ListTile(
                              title: Text(chats[position].firstName +
                                  " " +
                                  chats[position].lastName),
                              subtitle: Text("Room: " + chats[position].roomId),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.5),
                                child: Image.network(
                                  chats[position].avatar ??
                                      "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg",
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("Loading...");
                  }
                }),
          ),
        ],
      ),
    );
  }

  _openRoom(BuildContext context, ContactChat contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatUIDBPage(contactChat: contact)),
    );
  }
  _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

}
