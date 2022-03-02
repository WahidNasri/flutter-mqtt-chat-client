import 'package:floor/floor.dart';
import 'package:flutter_mqchat/models/enums.dart';

@DatabaseView(
    "SELECT m.id lastMessageId, m.type as lastMessageType, m.fromId lastMessageFromId, m.text lastMessageText, m.fromName lastMessageFromName, m.status lastMessageStatus, m.roomId roomId, r.name name, r.avatar avatar, r.isGroup isGroup  FROM message m"
    " "
    " "
    "JOIN room r ON r.id  = m.roomId "
    "JOIN (SELECT MAX(sendTime) maxtime, fromId, roomId from message group by roomId) latest on m.sendTime = latest.maxtime and m.roomId = latest.roomId ")
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
  final ChatMarker? lastMessageStatus;

  RecentChat(
      {required this.roomId,
      required this.name,
      this.avatar,
      required this.isGroup,
      required this.lastMessageId,
      required this.lastMessageType,
      required this.lastMessageText,
      required this.lastMessageFromId,
      this.lastMessageFromName,
      this.lastMessageStatus});
}
