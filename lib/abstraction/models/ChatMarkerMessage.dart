import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ChatMarker.dart';

import 'enums/MessageType.dart';

class ChatMarkerMessage {
  late String id;
  late MessageType type;
  late String fromId;
  String? roomId;
  late String referenceId;
  late ChatMarker status;
  ChatMarkerMessage({
    required this.id,
    required this.type,
    required this.fromId,
    this.roomId,
    required this.referenceId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type
          .toString()
          .substring(type.toString().toString().indexOf('.') + 1),
      'fromId': fromId,
      'roomId': roomId,
      'referenceId': referenceId,
      'status': status
          .toString()
          .substring(status.toString().toString().indexOf('.') + 1),
    };
  }

  factory ChatMarkerMessage.fromMap(Map<String, dynamic> map) {
    return ChatMarkerMessage(
      id: map['id'],
      type:
          MessageType.values.where((e) => describeEnum(e) == map['type']).first,
      fromId: map['fromId'],
      roomId: map['roomId'],
      referenceId: map['referenceId'],
      status: ChatMarker.values
          .where((e) => describeEnum(e) == map['marker'])
          .first,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMarkerMessage.fromJson(String source) =>
      ChatMarkerMessage.fromMap(json.decode(source));
}
