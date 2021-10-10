import 'dart:convert';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';

import 'enums/PresenceType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'PresenceMessage.g.dart';


@JsonSerializable()
@CopyWith()
class PresenceMessage extends BaseMessage{
  late String id;
  late PresenceType presenceType;
  late MessageType type;
  String? fromId;
  String? fromName;
  PresenceMessage({
    required this.id,
    required this.presenceType,
    required this.type,
    this.fromId,
    this.fromName,
  }):super(id: id, fromName: fromName, fromId:  fromId, type: type);

  factory PresenceMessage.fromJson(Map<String, dynamic> json) => _$PresenceMessageFromJson(json);
  factory PresenceMessage.fromString(String jsonString) => _$PresenceMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$PresenceMessageToJson(this);

}
