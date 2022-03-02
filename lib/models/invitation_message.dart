import 'dart:convert';

import 'package:flutter_mqchat/models/base_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitation_message.g.dart';

@JsonSerializable()
//@CopyWith()
class InvitationMessage extends BaseMessage {
  final String? fromAvatar;
  final String? text;

  InvitationMessage(
      {required String id,
      required MessageType type,
      String? fromId,
      String? fromName,
      this.fromAvatar,
      this.text,
      int? sendTime})
      : super(
            id: id,
            type: type,
            fromId: fromId,
            fromName: fromName,
            sendTime: sendTime);

  factory InvitationMessage.fromJson(Map<String, dynamic> json) =>
      _$InvitationMessageFromJson(json);

  factory InvitationMessage.fromString(payload) =>
      InvitationMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$InvitationMessageToJson(this);
}
