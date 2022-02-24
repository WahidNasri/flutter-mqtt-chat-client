import 'dart:convert';

import 'package:flutter_chat_mqtt/models/base_message.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_marker_message.g.dart';
@JsonSerializable()
//@CopyWith()
class ChatMarkerMessage extends BaseMessage {
  final String referenceId;
  final String? roomName;
  final ChatMarker status;

  ChatMarkerMessage(
      {required String id,
      required MessageType type,
      required this.referenceId,
      String? fromId,
      String? fromName,
      this.roomName,
      required this.status, int? sendTime})
      : super(
            id: id,
            type: type,
            fromName: fromName,
            fromId: fromId,
            sendTime: sendTime);

  factory ChatMarkerMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMarkerMessageFromJson(json);
  factory ChatMarkerMessage.fromString(String payload) => ChatMarkerMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$ChatMarkerMessageToJson(this);
}
