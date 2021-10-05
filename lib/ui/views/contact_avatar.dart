import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/ui/widgets/avatar_cancellable.dart';

class ContactAvatar extends StatelessWidget {
  final ContactChat chat;
  final double? radius;
  final int? borderWidth;
  final Color? borderColor;
  const ContactAvatar(
      {Key? key,
      required this.chat,
      this.radius,
      this.borderWidth,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chat.isGroup ?? false) {
      return _buildForGroup();
    } else {
      return _buildForContact();
    }
  }

  Widget _buildForGroup() {
    double theRadiusForImage = radius ?? 20;
    double iconSize = radius ?? 25;
    return chat.avatar != null
        ? CircleAvatar(
            foregroundImage: NetworkImage(chat.avatar!),
            radius: theRadiusForImage,
          )
        : CircleAvatar(
            child: Icon(
              Icons.group,
              size: iconSize,
            ),
            radius: theRadiusForImage,
          );
  }

  Widget _buildForContact() {
    double theRadiusForImage = radius ?? 20;
    double iconSize = radius ?? 25;
    int theBorderWidth = borderWidth ?? 0;

    return chat.avatar != null
        ? CircleAvatar(
            radius: theRadiusForImage + theBorderWidth,
            backgroundColor: borderColor ?? Colors.grey,
            child: CircleAvatar(
                foregroundImage: NetworkImage(
                  chat.avatar!,
                ),
                radius: theRadiusForImage),
          )
        : CircleAvatar(
            child: Icon(
              Icons.person,
              size: iconSize,
            ),
            radius: theRadiusForImage);
  }
}
