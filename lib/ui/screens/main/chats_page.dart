import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
import 'package:flutter_mqtt/ui/extensions/UiMessages.dart';
import 'package:flutter_mqtt/ui/screens/fromdb/chat_db_pages.dart';
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
                  var dt = DateTime.fromMillisecondsSinceEpoch(chats[position].send_time);
                  return InkWell(
                    onTap: () {
                      _openRoom(context, chats[position].toContactChat());
                    },
                    child: ListTile(
                      title: Text(chats[position].first_name +
                          " " +
                          chats[position].last_name),
                      subtitle: _subtitle(chats[position]),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.5),
                        child: Image.network(
                          chats[position].avatar ??
                              "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg",
                          height: 25,
                          width: 25,
                        ),
                      ),
                      trailing: Text(DateFormat('HH:mm').format(dt)),//TODO: need more detailed formatting
                    ),
                  );
                });
          }

          return Text("Loading..");
        });
  }
  Widget _subtitle(ExtendedDbContact chat){
    if(chat.message_type == "ChatImage"){
      return Row(children: [Icon(Icons.image, size: 15,), Text("Image")]);
    }
    else if(chat.message_type == "ChatDocument"){
      return Row(children: [Icon(Icons.attach_file_rounded, size: 15,), Text("File")]);
    }
    return Text(chat.message_text, maxLines: 1,);
  }
  _openRoom(BuildContext context, ContactChat contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatUIDBPage(contactChat: contact)),
    );
  }
}
