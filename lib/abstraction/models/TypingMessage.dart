import 'dart:convert';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';

import 'enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'TypingMessage.g.dart';

@JsonSerializable()
@CopyWith()
class TypingMessage extends BaseMessage{
  final String id;
  final MessageType type;
  final String fromId;
  final String fromName;
  final String? roomId;
  @JsonKey(fromJson: _isTypingFromJson)
  final bool isTyping;
  TypingMessage({
    required this.id,
    required this.type,
    required this.fromId,
    required this.fromName,
    this.roomId,
    required this.isTyping,
  }):super(id: id, fromId: fromId, fromName: fromName, type: type);

  factory TypingMessage.fromJson(Map<String, dynamic> json) => _$TypingMessageFromJson(json);
  factory TypingMessage.fromString(String jsonString) => _$TypingMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$TypingMessageToJson(this);


  static bool _isTypingFromJson(String boolStr) =>
      boolStr.toLowerCase() == "true";
}
