import 'package:example/database/models/recent_chat.dart';
import 'package:example/database/models/room.dart';
import 'package:example/ui/extensions/rooms_extensions.dart';
import 'package:flutter/material.dart';

class RoomAvatar extends StatelessWidget {
  final Room room;
  final double radius;
  final double statusWidth;
  const RoomAvatar(
      {Key? key, required this.room, this.radius = 20, this.statusWidth = 2})
      : super(key: key);

  factory RoomAvatar.fromRecentChat(
          {required RecentChat recentChat,
          double radius = 20,
          double statusWidth = 2}) =>
      RoomAvatar(
          room: Room(
              id: recentChat.roomId,
              name: recentChat.name,
              isGroup: recentChat.isGroup),
          radius: radius,
          statusWidth: statusWidth);

  @override
  Widget build(BuildContext context) {
    if (room.avatar != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: room.presenceColor,
        child: CircleAvatar(
          radius: radius - (room.isGroup ? 0 : statusWidth),
          foregroundImage: room.avatar != null && room.avatar!.isNotEmpty ? NetworkImage(room.avatar!) : null,
          child: room.avatar  == null && room.avatar!.isEmpty ? Icon(room.isGroup ? Icons.group : Icons.person, size: 50,) : null,
        ),
      );
    } else {
      CircleAvatar(
        radius: radius,
        foregroundColor: room.presenceColor,
        child: CircleAvatar(
            radius: radius - (room.isGroup ? 0 : statusWidth),
            child: Icon(room.isGroup ? Icons.group : Icons.person, size: 50,)),
      );
    }
    return Container();
  }
}
