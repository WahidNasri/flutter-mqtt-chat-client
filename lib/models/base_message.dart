import 'dart:convert';

import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_message.g.dart';

@JsonSerializable()
//@CopyWith()
class BaseMessage {
  final String id;
  final MessageType type;
  final String? fromId;
  final String? fromName;
  @JsonKey(fromJson: sendTimeFromJson)
  final int? sendTime;

  BaseMessage(
      {required this.id,
      required this.type,
      this.fromId,
      this.fromName,
      this.sendTime});

  factory BaseMessage.fromJson(Map<String, dynamic> json) =>
      _$BaseMessageFromJson(json);

  factory BaseMessage.fromString(String payload) => BaseMessage.fromJson(json.decode(payload));
  Map<String, dynamic> toJson() => _$BaseMessageToJson(this);

  bool isChatMessage() {
    return type == MessageType.chatAudio ||
        type == MessageType.chatContact ||
        type == MessageType.chatDocument ||
        type == MessageType.chatImage ||
        type == MessageType.chatLocation ||
        type == MessageType.chatText ||
        type == MessageType.chatVideo;
  }

  bool isPresenceEvent() {
    return type == MessageType.presence;
  }

  bool isInvitationEvent() {
    return type == MessageType.invitationRequest ||
        type == MessageType.invitationResponseAccept ||
        type == MessageType.invitationResponseReject;
  }

  bool isInvitationResponseEvent() {
    return type == MessageType.invitationResponseAccept ||
        type == MessageType.invitationResponseReject;
  }

  bool isChatMarkerEvent() {
    return type == MessageType.chatMarker;
  }

  bool isTypingEvent() {
    return type == MessageType.typing || type == MessageType.typing;
  }

  static int sendTimeFromJson(dynamic milliseconds) {
    if(milliseconds == null){
      return DateTime.now().millisecondsSinceEpoch;
    }
    if (milliseconds is String) {
      return int.tryParse(milliseconds) ?? 0;
    } else if (milliseconds is int) {
      return milliseconds;
    } else {
      return int.tryParse(milliseconds) ?? 0;
    }
  }


  DateTime? get dateTime {
    if(sendTime != null){
      return DateTime.fromMillisecondsSinceEpoch(sendTime!);
    }
    return null;
  }

}
