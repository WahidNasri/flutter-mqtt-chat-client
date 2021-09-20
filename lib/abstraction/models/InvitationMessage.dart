import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';

class InvitationMessage {
  late String id;
  late MessageType type;
  late InvitationMessageType invitationMessageType;
  String? text;
  String? fromId;
  String? fromName;
  String? fromAvatar;

  InvitationMessage(
      {required this.id,
      required this.type,
      required this.invitationMessageType,
      this.text,
      this.fromId,
      this.fromName,
      this.fromAvatar});

  InvitationMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //type = MessageType.values[json['type']];
    type =
        MessageType.values.where((e) => describeEnum(e) == json['type']).first;
    invitationMessageType = InvitationMessageType.values
        .where((e) => describeEnum(e) == json['invitationMessageType'])
        .first;
    text = json['text'];
    fromId = json['fromId'];
    fromName = json['fromName'];
    fromAvatar = json['fromAvatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['invitationMessageType'] = this.invitationMessageType;
    data['text'] = this.text;
    data['fromId'] = this.fromId;
    data['fromName'] = this.fromName;
    data['fromAvatar'] = this.fromAvatar;
    return data;
  }
}
