import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';

import 'enums/PresenceType.dart';

class PresenceMessage {
  late String id;
  late PresenceType presenceType;
  late MessageType type;
  String? fromId;
  String? fromName;
  PresenceMessage({
    required this.id,
    required this.presenceType,
    required this.type,
    this.fromId,
    this.fromName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type
          .toString()
          .substring(type.toString().toString().indexOf('.') + 1),
      'presenceType': presenceType
          .toString()
          .substring(presenceType.toString().toString().indexOf('.') + 1),
      'fromId': fromId,
      'fromName': fromName,
    };
  }

  factory PresenceMessage.fromMap(Map<String, dynamic> map) {
    return PresenceMessage(
      id: map['id'],
      presenceType: PresenceType.values
          .where((e) => describeEnum(e) == map['presenceType'])
          .first,
      type: MessageType.values
          .where((e) => describeEnum(e) == map['type'])
          .first,
      fromId: map['fromId'],
      fromName: map['fromName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PresenceMessage.fromJson(String source) =>
      PresenceMessage.fromMap(json.decode(source));
}
