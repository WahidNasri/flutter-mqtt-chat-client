import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';

class ContactChat {
  String firstName;
  String lastName;
  String id;
  String? avatar;
  String roomId;
  PresenceType? presence;
  bool? isGroup;
  ContactChat(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.avatar,
      required this.roomId,
      required this.isGroup,
      this.presence});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'avatar': avatar,
      'roomId': roomId,
      'isGroup': isGroup,
      'presence': presence,
    };
  }

  factory ContactChat.fromMap(Map<String, dynamic> map) {
    return ContactChat(
      firstName: map['firstName'],
      lastName: map['lastName'],
      id: map['id'],
      avatar: map['avatar'],
      roomId: map['roomId'],
      presence: map['presence'] == null ? null :  PresenceType.values
          .where((e) => describeEnum(e) == map['presence'])
          .first,
      isGroup: map['isGroup'] != null && map['isGroup'] == true,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactChat.fromJson(String source) =>
      ContactChat.fromMap(json.decode(source));
}
