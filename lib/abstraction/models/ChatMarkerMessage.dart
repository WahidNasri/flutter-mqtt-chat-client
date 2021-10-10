import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ChatMarker.dart';

import 'enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ChatMarkerMessage.g.dart';

@JsonSerializable()
@CopyWith()
class ChatMarkerMessage extends BaseMessage{
  late String id;
  late MessageType type;
  late String fromId;
  String? roomId;
  late String referenceId;
  late ChatMarker status;
  ChatMarkerMessage({
    required this.id,
    required this.type,
    required this.fromId,
    this.roomId,
    required this.referenceId,
    required this.status,
  }):super(id: id, fromId: fromId, fromName: "", type: type);

  factory ChatMarkerMessage.fromJson(Map<String, dynamic> json) => _$ChatMarkerMessageFromJson(json);
  factory ChatMarkerMessage.fromString(String jsonString) => _$ChatMarkerMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ChatMarkerMessageToJson(this);

}
