import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';

class ExtendedDbContact {
  final String id;
  final String first_name;
  final String last_name;
  final String? avatar;
  final String room_id;
  final PresenceType? presence;
  final String message_type;
  final String message_id;
  final String message_text;
  final String message_originality;
  final int send_time;
  final bool is_group;

  ExtendedDbContact(
      {required this.id,
      required this.first_name,
      required this.last_name,
      this.avatar,
      required this.room_id,
      required this.message_type,
      required this.message_id,
        required this.message_text,
      required this.message_originality,
      required this.send_time,
      required this.is_group,
        this.presence});

  factory ExtendedDbContact.fromJson(Map<String, dynamic> json) {
    return ExtendedDbContact(
      id: json["id"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      avatar: json["avatar"],
      room_id: json["room_id"],
      message_type: json["message_type"],
      message_id: json["message_id"],
      message_text: json["message_text"],
      message_originality: json["message_originality"],
      send_time: int.parse(json["send_time"].toString()),
      is_group: json["is_group"] == 1,
      presence: json['presence'] == null ? null :  PresenceType.values
          .where((e) => describeEnum(e) == json['presence'])
          .first,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "first_name": this.first_name,
      "last_name": this.last_name,
      "avatar": this.avatar,
      "room_id": this.room_id,
      "message_type": this.message_type,
      "message_id": this.message_id,
      "message_text": this.message_text,
      "message_originality": this.message_originality,
      "send_time": this.send_time,
      "is_group": this.is_group,
      "presence": this.presence
    };
  }
//

}
