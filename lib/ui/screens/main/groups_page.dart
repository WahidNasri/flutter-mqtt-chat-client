import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/ui/items/contact_or_group_item.dart';
import 'package:flutter_mqtt/ui/screens/chatting/chat_db_pages.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ContactChat>>(
        stream: AppData.instance()!.contactsHandler.getGroups(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            final groups = snapshot.data;
            return ListView.builder(
                itemCount: groups!.length, itemBuilder: (context, position) {
                  return ContactOrGroupItem(chat: groups[position], onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatUIDBPage(contactChat: groups[position])),
                    );
                  });
            });
          }
          return Container();
        });
  }
}
