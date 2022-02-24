import 'dart:convert';

import 'package:flutter_chat_mqtt/models/base_message.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'typing_indicator_message.g.dart';

@JsonSerializable()
//@CopyWith()
class TypingIndicatorMessage extends BaseMessage {
  @JsonKey(fromJson: boolFromJson)
  final bool isTyping;
  final String roomId;

  TypingIndicatorMessage(
      {required String id,
      required MessageType type,
      required this.isTyping,
        required this.roomId,
      String? fromId,
      String? fromName,
      int? sendTime})
      : super(
            id: id,
            type: type,
            fromId: fromId,
            fromName: fromName,
            sendTime: sendTime);

  factory TypingIndicatorMessage.fromJson(Map<String, dynamic> json) =>
      _$TypingIndicatorMessageFromJson(json);
  factory TypingIndicatorMessage.fromString(String payload) =>
      TypingIndicatorMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$TypingIndicatorMessageToJson(this);

  static bool boolFromJson(dynamic value){
    if(value == null){
      return false;
    }
    if(value is String){
      return value.toLowerCase() == "true";
    }
    else if(value is bool){
      return value;
    }
    else if(value is int){
      return value > 0;
    }
    return false;
  }
}
