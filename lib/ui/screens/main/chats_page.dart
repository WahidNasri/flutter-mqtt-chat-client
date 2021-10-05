import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';
import 'package:flutter_mqtt/ui/items/contact_or_group_item.dart';
import 'package:flutter_mqtt/ui/screens/chatting/chat_db_pages.dart';
import 'package:intl/intl.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExtendedDbContact>>(
        stream: AppData.instance()!.messagesHandler.getRecentMessages(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var chats = snapshot.data;
            return ListView.builder(
                itemCount: chats!.length,
                itemBuilder: (context, position) {
                  var dt = DateTime.fromMillisecondsSinceEpoch(
                      chats[position].send_time);
                  return ContactOrGroupItem(
                      chat: chats[position].toContactChat(),
                      subtitle: _subtitle(chats[position]),
                      trailing: Text(DateFormat('HH:mm').format(dt)),
                      avatarBorderWidth: chats[position].is_group ? 0 : 2,
                      avatarBorderColor: chats[position].is_group ? null : Colors.grey,//fixme: use color for presence
                      onTap: () {
                        _openRoom(context, chats[position].toContactChat());
                      });
                });
          }

          return Text("Loading..");
        });
  }

  Widget _subtitle(ExtendedDbContact chat) {
    if (chat.message_type == "ChatImage") {
      return Row(children: [
        Icon(
          Icons.image,
          size: 15,
        ),
        Text("Image")
      ]);
    } else if (chat.message_type == "ChatDocument") {
      return Row(children: [
        Icon(
          Icons.attach_file_rounded,
          size: 15,
        ),
        Text("File")
      ]);
    }
    return Text(
      chat.message_text,
      maxLines: 1,
    );
  }

  _openRoom(BuildContext context, ContactChat contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatUIDBPage(contactChat: contact)),
    );
  }
}
