import 'dart:convert';

import 'package:flutter_mqchat/models/base_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presence_message.g.dart';

@JsonSerializable()
//@CopyWith()
class PresenceMessage extends BaseMessage {
  final PresenceType presenceType;

  PresenceMessage(
      {required String id,
      required MessageType type,
      required this.presenceType,
      String? fromId,
      String? fromName,
      int? sendTime})
      : super(
            id: id,
            type: type,
            fromName: fromName,
            fromId: fromId,
            sendTime: sendTime);

  factory PresenceMessage.fromJson(Map<String, dynamic> json) =>
      _$PresenceMessageFromJson(json);
  factory PresenceMessage.fromString(String payload) =>
      PresenceMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$PresenceMessageToJson(this);
}
