import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';

class BaseMessage {
  late String id;
  late MessageType type;
  String? fromId;
  String? fromName;

  BaseMessage(
      {required this.id, required this.type, this.fromId, this.fromName});

  BaseMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //type = MessageType.values[json['type']];
    type =
        MessageType.values.where((e) => describeEnum(e) == json['type']).first;
    fromId = json['fromId'];
    fromName = json['fromName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['fromId'] = this.fromId;
    data['fromName'] = this.fromName;
    return data;
  }

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
