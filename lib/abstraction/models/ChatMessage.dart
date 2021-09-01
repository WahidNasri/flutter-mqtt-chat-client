import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'enums/MessageOriginality.dart';
import 'enums/MessageType.dart';

class ChatMessage {
  late String id;
  late MessageType type;
  String? fromId;
  String? fromName;
  String? toId;
  String? toName;
  late String text;
  String roomId;
  MessageOriginality originality;
  String? attachment;
  String? thumbnail;
  String? originalId;
  String? originalMessage;
  late int sendTime;
  List<String>? additionalFields;
  ChatMessage(
      {required this.id,
      required this.type,
      this.fromId,
      this.fromName,
      this.toId,
      this.toName,
      required this.text,
      required this.roomId,
      this.originality = MessageOriginality.Original,
      this.attachment,
      this.thumbnail,
      this.originalId,
      this.originalMessage,
      required this.sendTime,
      this.additionalFields});

  ChatMessage copyWith({
    String? id,
    MessageType? type,
    String? fromId,
    String? fromName,
    String? toId,
    String? toName,
    String? text,
    String? roomId,
    MessageOriginality? originality,
    String? attachment,
    String? thumbnail,
    String? originalId,
    String? originalMessage,
    int? sendTime,
    List<String>? additionalFields,
  }) {
    return ChatMessage(
        id: id ?? this.id,
        type: type ?? this.type,
        fromId: fromId ?? this.fromId,
        fromName: fromName ?? this.fromName,
        toId: toId ?? this.toId,
        toName: toName ?? this.toName,
        text: text ?? this.text,
        roomId: roomId ?? this.roomId,
        originality: originality ?? this.originality,
        attachment: attachment ?? this.attachment,
        thumbnail: thumbnail ?? this.thumbnail,
        originalId: originalId ?? this.originalId,
        originalMessage: originalMessage ?? this.originalMessage,
        sendTime: sendTime ?? DateTime.now().millisecondsSinceEpoch,
        additionalFields: additionalFields ?? this.additionalFields);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type
          .toString()
          .substring(type.toString().toString().indexOf('.') + 1),
      'fromId': fromId,
      'fromName': fromName,
      'toId': toId,
      'toName': toName,
      'text': text,
      'roomId': roomId,
      'originality': originality
          .toString()
          .substring(originality.toString().toString().indexOf('.') + 1),
      'attachment': attachment,
      'thumbnail': thumbnail,
      'originalId': originalId,
      'originalMessage': originalMessage,
      'sendTime': sendTime,
      'additionalFields': additionalFields.toString()
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      type:
          MessageType.values.where((e) => describeEnum(e) == map['type']).first,
      fromId: map['fromId'],
      fromName: map['fromName'],
      toId: map['toId'],
      toName: map['toName'],
      text: map['text'],
      roomId: map['roomId'],
      originality: map['originality'] != null
          ? MessageOriginality.values
              .where((e) => describeEnum(e) == map['originality'])
              .first
          : MessageOriginality.Original,
      attachment: map['attachment'],
      thumbnail: map['thumbnail'],
      originalId: map['originalId'],
      sendTime: map['sendTime'] == null
          ? DateTime.now().millisecondsSinceEpoch
          : int.tryParse(map['sendTime']) ??
              DateTime.now().millisecondsSinceEpoch,
      originalMessage: map['originalMessage'],
    );
  }

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatMessage(id: $id, type: $type, fromId: $fromId, fromName: $fromName, toId: $toId, toName: $toName, text: $text, attachment: $attachment, thumbnail: $thumbnail, originalId: $originalId, originalMessage: $originalMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.id == id &&
        other.type == type &&
        other.fromId == fromId &&
        other.fromName == fromName &&
        other.toId == toId &&
        other.toName == toName &&
        other.text == text &&
        other.attachment == attachment &&
        other.thumbnail == thumbnail &&
        other.originalId == originalId &&
        other.originalMessage == originalMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        fromId.hashCode ^
        fromName.hashCode ^
        toId.hashCode ^
        toName.hashCode ^
        text.hashCode ^
        attachment.hashCode ^
        thumbnail.hashCode ^
        originalId.hashCode ^
        originalMessage.hashCode;
  }
}
