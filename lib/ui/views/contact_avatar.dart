import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';

class ContactAvatar extends StatelessWidget {
  final ContactChat chat;
  final double? radius;
  const ContactAvatar({Key? key, required this.chat, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chat.isGroup ?? false) {
      return chat.avatar != null
          ? CircleAvatar(
              foregroundImage: NetworkImage(chat.avatar!),
              radius: radius ?? 20,
            )
          : CircleAvatar(
              child: Icon(
                Icons.group,
                size: radius ?? 25,
              ),
              radius: radius ?? 20,
            );
    } else {
      return chat.avatar != null
          ? CircleAvatar(
              foregroundImage: NetworkImage(
                chat.avatar!,
              ),
              radius: radius ?? 20)
          : CircleAvatar(
              child: Icon(
                Icons.person,
                size: radius ?? 25,
              ),
              radius: radius ?? 20);
    }
  }
}
