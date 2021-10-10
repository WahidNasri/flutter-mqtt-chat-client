import 'dart:convert';

import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'BaseMessage.g.dart';

@JsonSerializable()
@CopyWith()
class BaseMessage {
  final String id;
  final MessageType type;
  final String? fromId;
  final String? fromName;

  BaseMessage(
      {required this.id, required this.type, this.fromId, this.fromName});

  factory BaseMessage.fromJson(Map<String, dynamic> json) => _$BaseMessageFromJson(json);
  factory BaseMessage.fromString(String jsonString) => _$BaseMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$BaseMessageToJson(this);

  bool isChatMessage() {
    return type == MessageType.ChatAudio ||
        type == MessageType.ChatContact ||
        type == MessageType.ChatDocument ||
        type == MessageType.ChatImage ||
        type == MessageType.ChatLocation ||
        //type == MessageType.ChatMarker ||
        type == MessageType.ChatText ||
        type == MessageType.ChatVideo;
  }

  bool isPresence() {
    return type == MessageType.Presence;
  }

  bool isInvitationEvent() {
    return type == MessageType.EventInvitationRequest ||
        type == MessageType.EventInvitationResponseAccept ||
        type == MessageType.EventInvitationResponseReject;
  }

  bool isChatMarkerEvent() {
    return type == MessageType.ChatMarker;
  }

  bool isTypingEvent() {
    return type == MessageType.Typing || type == MessageType.Typing;
  }
}
