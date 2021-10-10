import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'InvitationMessage.g.dart';

@JsonSerializable()
@CopyWith()

class InvitationMessage extends BaseMessage{
  late String id;
  late MessageType type;
  late InvitationMessageType invitationMessageType;
  String? text;
  String? fromId;
  String? fromName;
  String? fromAvatar;
  late int sendTime;

  InvitationMessage(
      {required this.id,
      required this.type,
      required this.invitationMessageType,
      this.text,
      this.fromId,
      this.fromName,
      this.fromAvatar,
      required this.sendTime}):super(id: id, fromId: fromId, fromName:  fromName, type: type);

  factory InvitationMessage.fromJson(Map<String, dynamic> json) => _$InvitationMessageFromJson(json);
  factory InvitationMessage.fromString(String jsonString) => _$InvitationMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$InvitationMessageToJson(this);

}
