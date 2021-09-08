import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/chat_db_pages.dart';
import 'package:flutter_mqtt/ui/screens/login_page.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart' as cs;
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
        title: Column(
          children: [
            Text("Rooms"),
            StreamBuilder<cs.ConnectionState>(stream: ChatApp.instance()!.clientHandler.connectionStateStream(), builder: (context, snapshot){
              if(snapshot.hasError){
                return Text(snapshot.error.toString(), style: TextStyle(color: Colors.red, fontSize: 15),);
              }
              else if(snapshot.hasData){
                return Text(snapshot.data.toString().split(".")[1] , style: TextStyle(fontSize: 12));
              }
              return Text("Loading Connection State...", style: TextStyle(fontSize: 15));
            })
          ],
        ),
        actions: [IconButton(onPressed: _onLogout, icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          // A stream builder to indicate that the user info is not received yet from the broker
        StreamBuilder(stream: AppData.instance()!.usersHandler.getLocalUserAsync(), builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data != null){
            return SizedBox();
          }
          else if(snapshot.hasError){
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
                              leading: FlutterLogo(),
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
      MaterialPageRoute(builder: (context) => ChatUIDBPage(contactChat: contact)),
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
