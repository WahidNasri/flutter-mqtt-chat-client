import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'enums/PresenceType.dart';

class PresenceMessage {
  late String id;
  late PresenceType type;
  String? fromId;
  String? fromName;
  PresenceMessage({
    required this.id,
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
      'fromId': fromId,
      'fromName': fromName,
    };
  }

  factory PresenceMessage.fromMap(Map<String, dynamic> map) {
    return PresenceMessage(
      id: map['id'],
      type: PresenceType.values
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
