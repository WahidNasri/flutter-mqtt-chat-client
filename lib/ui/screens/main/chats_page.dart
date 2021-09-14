import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
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
                      //_openRoom(context, chats[position]);
                    },
                    child: ListTile(
                      title: Text(chats[position].first_name +
                          " " +
                          chats[position].last_name),
                      subtitle: Text(chats[position].message_text),
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
}
