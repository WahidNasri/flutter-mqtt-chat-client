import 'package:example/database/models/recent_chat.dart';
import 'package:example/database/models/room.dart';
import 'package:example/ui/extensions/rooms_extensions.dart';
import 'package:flutter/material.dart';

class RoomAvatar extends StatefulWidget {
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
  State<RoomAvatar> createState() => _RoomAvatarState();
}

class _RoomAvatarState extends State<RoomAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.room.avatar != null && widget.room.avatar!.isNotEmpty) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundColor: widget.room.presenceColor,
        child: CircleAvatar(
          radius:
              widget.radius - (widget.room.isGroup ? 0 : widget.statusWidth),
          foregroundImage:
              widget.room.avatar != null && widget.room.avatar!.isNotEmpty
                  ? NetworkImage(widget.room.avatar!)
                  : null,
          child: widget.room.avatar == null && widget.room.avatar!.isEmpty
              ? Icon(
                  widget.room.isGroup ? Icons.group : Icons.person,
                  size: widget.radius,
                )
              : null,
        ),
      );
    } else {
      return CircleAvatar(
        radius: widget.radius,
        foregroundColor: widget.room.presenceColor,
        child: CircleAvatar(
            radius:
                widget.radius - (widget.room.isGroup ? 0 : widget.statusWidth),
            child: Icon(
              widget.room.isGroup ? Icons.group : Icons.person,
              size: widget.radius,
            )),
      );
    }
  }
}
