import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/ui/views/contact_avatar.dart';

class ContactOrGroupItem extends StatelessWidget {
  final ContactChat chat;
  final Function()? onTap;
  final Widget? subtitle;
  final Widget? trailing;
  const ContactOrGroupItem({Key? key, required this.chat, this.onTap, this.subtitle, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Row(
          children: [
            (chat.isGroup ?? false
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.group, size: 18),
                  )
                : SizedBox()),
            Text(chat.firstName + " " + chat.lastName),
          ],
        ),
        subtitle: subtitle ?? Text("Room: " + chat.roomId),
        leading: Hero(tag: "avatar_" + chat.id, child: ContactAvatar(chat: chat)),
        trailing: trailing,
      ),
    );
  }
}
