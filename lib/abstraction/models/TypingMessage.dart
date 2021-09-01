import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'enums/MessageType.dart';

class TypingMessage {
  late String id;
  late MessageType type;
  late String fromId;
  String? roomId;
  late bool isTyping;
  TypingMessage({
    required this.id,
    required this.type,
    required this.fromId,
    this.roomId,
    required this.isTyping,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type
          .toString()
          .substring(type.toString().toString().indexOf('.') + 1),
      'fromId': fromId,
      'roomId': roomId,
      'isTyping': isTyping,
    };
  }

  factory TypingMessage.fromMap(Map<String, dynamic> map) {
    return TypingMessage(
      id: map['id'],
      type:
          MessageType.values.where((e) => describeEnum(e) == map['type']).first,
      fromId: map['fromId'],
      roomId: map['roomId'],
      isTyping: map['isTyping'] != null && map['isTyping'] == "true",
    );
  }

  String toJson() => json.encode(toMap());

  factory TypingMessage.fromJson(String source) =>
      TypingMessage.fromMap(json.decode(source));
}
