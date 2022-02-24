import 'package:floor/floor.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
@DatabaseView("SELECT m.id lastMessageId, m.type as lastMessageType, m.fromId lastMessageFromId, m.text lastMessageText, m.fromName lastMessageFromName, m.roomId roomId, r.name name, r.avatar avatar, r.isGroup isGroup  FROM message m"
    " "
    " "
    "JOIN room r ON r.id  = m.roomId "
    "JOIN (SELECT MAX(sendTime) maxtime, fromId from message group by fromId) latest on m.sendTime = latest.maxtime and m.fromId = latest.fromID ")

class RecentChat {
  final String roomId;
  final String name;
  final String? avatar;
  final bool isGroup;
  final String lastMessageId;
  final MessageType lastMessageType;
  final String lastMessageText;
  final String lastMessageFromId;
  final String? lastMessageFromName;

  RecentChat(
      {required this.roomId,
      required this.name,
      this.avatar,
      required this.isGroup,
      required this.lastMessageId,
      required this.lastMessageType,
      required this.lastMessageText,
      required this.lastMessageFromId,
      this.lastMessageFromName});
}
