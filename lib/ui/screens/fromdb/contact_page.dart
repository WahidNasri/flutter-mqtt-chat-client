import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/media_messages_page.dart';
import 'package:flutter_mqtt/ui/widgets/menu_action_item.dart';
import 'package:flutter_mqtt/ui/widgets/menu_action_item_switch.dart';

class ContactDetailsPage extends StatefulWidget {
  final ContactChat contactChat;
  const ContactDetailsPage({Key? key, required this.contactChat})
      : super(key: key);

  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool muted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "avatar_" + widget.contactChat.id,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CircleAvatar(
                    foregroundImage:
                        NetworkImage(widget.contactChat.avatar ?? ""),
                    radius: 100,
                  ),
                ),
              ),
              Text(
                widget.contactChat.firstName +
                    " " +
                    widget.contactChat.lastName,
                style: TextStyle(fontSize: 25),
              ),
              _starredItem(),
              Divider(),
              _mediaItem(),
              Divider(),
              MenuSwitchItem(
                title: "Mute",
                leading:
                    Icon(muted ? Icons.notifications_off : Icons.notifications),
                active: muted,
                onChanged: (bool) {
                  setState(() {
                    muted = bool;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaItem() {
    return StreamBuilder<List<ChatMessage>>(
        stream: AppData.instance()!.messagesHandler.getMediaMessagesByRoomId(widget.contactChat.roomId),
        builder: (context, snapshot) {
          String count = snapshot.hasData ? snapshot.data!.length.toString() : snapshot.hasError ? "E" : "Loading...";
          return MenuActionItem(
              title: "Media Messages",
              trailingText: count,
              leading: Icon(Icons.perm_media),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MediaMessagesPage(contactChat: widget.contactChat)),
                );
              });
        });
  }
  Widget _starredItem(){
    return MenuActionItem(
        title: "Starred Messages",
        trailingText: "0",
        leading: Icon(Icons.stars_sharp),
        onTap: () {});
  }
}
