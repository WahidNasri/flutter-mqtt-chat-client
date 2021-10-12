import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'enums/MessageOriginality.dart';
import 'enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ChatMessage.g.dart';

@JsonSerializable()
@CopyWith()
class ChatMessage extends BaseMessage {
  final String id;
  final MessageType type;
  final String? fromId;
  final String? fromName;
  final String? toId;
  final String? toName;
  final String text;
  final String roomId;
  final MessageOriginality originality;
  final String? attachment;
  final String? thumbnail;
  final String? originalId;
  final String? originalMessage;
  @JsonKey(fromJson: _sendTimeFromJson)
  final int sendTime;
  final int? size;
  final String? mime;
  @JsonKey(fromJson: _latLngFromJson)
  final double? longitude;
  @JsonKey(fromJson: _latLngFromJson)
  final double? latitude;
  final List<String>? additionalFields;
  ChatMessage(
      {required this.id,
      required this.type,
      this.fromId,
      this.fromName,
      this.toId,
      this.toName,
      required this.text,
      required this.roomId,
      this.originality = MessageOriginality.Original,
      this.attachment,
      this.thumbnail,
      this.originalId,
      this.originalMessage,
      required this.sendTime,
      this.size,
      this.mime,
      this.additionalFields,
      this.longitude,
      this.latitude})
      : super(id: id, fromId: fromId, fromName: fromId, type: type);

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  factory ChatMessage.fromString(String jsonString) =>
      _$ChatMessageFromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  static double? _latLngFromJson(dynamic value) {
    var type = value.runtimeType;
    if (value == null) {
      return null;
    }
    if(value is String){
      return double.tryParse(value);
    }
    if (value is num) {
      return value.toDouble();
    } else {
      double.tryParse(value);
    }
  }

  static int _sendTimeFromJson(dynamic milliseconds) {
    if (milliseconds is String) {
      return int.tryParse(milliseconds) ?? 0;
    } else if (milliseconds is int) {
      return milliseconds;
    } else {
      return int.tryParse(milliseconds) ?? 0;
    }
  }
}
