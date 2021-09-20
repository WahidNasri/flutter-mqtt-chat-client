import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:uuid/uuid.dart';

enum ViewState { CONTACTS, INVITATIONS }

class NewChatView extends StatefulWidget {
  final Function(ContactChat)? openRoom;
  const NewChatView({Key? key, this.openRoom}) : super(key: key);

  @override
  _NewChatViewState createState() => _NewChatViewState();
}

class _NewChatViewState extends State<NewChatView> {
  ViewState view = ViewState.CONTACTS;
  TextEditingController _usernameController = TextEditingController();
  String update = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: view == ViewState.CONTACTS
            ? SizedBox()
            : IconButton(
                onPressed: _back,
                icon: Icon(Icons.keyboard_arrow_left_outlined)),
        title: Text("New Chat"),
        actions: [
          IconButton(
              tooltip: "Create New Group",
              onPressed: _createGroupTap,
              icon: Icon(Icons.group_add)),
          IconButton(
              tooltip: "Invite a person to chat",
              onPressed: _inviteTap,
              icon: Icon(Icons.person_add))
        ],
      ),
      body: view == ViewState.CONTACTS ? _contactsView() : _invitationView(),
    );
  }

  Widget _contactsView() {
    return StreamBuilder<List<ContactChat>>(
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
                      Navigator.pop(context);
                      widget.openRoom!(chats[position]);
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
        });
  }

  Widget _invitationView() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: _usernameController,
            decoration: InputDecoration(
                hintText: "Email to invite",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          SizedBox(height: 20),
          Text(update),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ])),
            child: InkWell(
              onTap: _sendInvitation,
              child: Center(
                child: Text(
                  "Send Invitation",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _createGroupTap() {}

  void _inviteTap() {
    setState(() {
      view = ViewState.INVITATIONS;
    });
  }

  void _back() {
    setState(() {
      view = ViewState.CONTACTS;
    });
  }

  void _sendInvitation() {
    String id = Uuid().v4();
    ChatApp.instance()!
        .eventsSender
        .sendInvitation(_usernameController.text, id);

    AppData.instance()!.invitationsHandler.addInvitationRequest(id);

    ChatApp.instance()!
        .invitationHandler
        .invitationUpdatesStream()
        .listen((event) {
      if (event.id == id) {
        setState(() {
          update = event.text ?? "update";
        });
      }
    });
  }
}
