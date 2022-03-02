import 'dart:convert';

import 'package:flutter_mqchat/models/base_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
//@CopyWith()
class ChatMessage extends BaseMessage {
  final String? toId;
  final String? toName;
  final String text;
  final String roomId;
  final MessageOriginality originality;
  final String? attachment;
  final String? thumbnail;
  final String? originalId;
  final String? originalMessage;
  final int? size;
  final String? mime;
  @JsonKey(fromJson: _latLngFromJson)
  final double? longitude;
  @JsonKey(fromJson: _latLngFromJson)
  final double? latitude;

  ChatMessage(
      {required String id,
      required MessageType type,
      String? fromId,
      String? fromName,
      this.toId,
      this.toName,
      required this.text,
      required this.roomId,
      this.originality = MessageOriginality.original,
      this.attachment,
      this.thumbnail,
      this.originalId,
      this.originalMessage,
      int? sendTime,
      this.size,
      this.mime,
      this.longitude,
      this.latitude})
      : super(
            id: id,
            type: type,
            fromId: fromId,
            fromName: fromName,
            sendTime: sendTime);

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  factory ChatMessage.fromString(String payload) =>
      ChatMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  ChatMessage copyWith(
      {String? id,
      MessageType? type,
      String? fromId,
      String? fromName,
      String? toId,
      String? toName,
      String? text,
      String? roomId,
      MessageOriginality? originality,
      String? attachment,
      String? thumbnail,
      String? originalId,
      String? originalMessage,
      int? sendTime,
      int? size,
      String? mime,
      double? longitude,
      double? latitude}) {
    return ChatMessage(
        id: id ?? this.id,
        type: type ?? this.type,
        fromId: fromId ?? this.fromId,
        fromName: fromName ?? this.fromName,
        toId: toId ?? this.toId,
        toName: toName ?? this.toName,
        text: text ?? this.text,
        roomId: roomId ?? this.roomId,
        originality: originality ?? this.originality,
        attachment: attachment ?? this.attachment,
        thumbnail: thumbnail ?? this.thumbnail,
        originalId: originalId ?? this.originalId,
        originalMessage: originalMessage ?? this.originalMessage,
        sendTime: sendTime ?? this.sendTime,
        size: size ?? this.size,
        mime: mime ?? this.mime,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude);
  }

  static double? _latLngFromJson(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    if (value is num) {
      return value.toDouble();
    } else {
      return double.tryParse(value);
    }
  }
}
