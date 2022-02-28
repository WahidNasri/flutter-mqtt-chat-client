import 'package:floor/floor.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
@entity
class Message {
  @primaryKey
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
  final int? size;
  final String? mime;
  final double? longitude;
  final double? latitude;
  final DateTime sendTime;
  final ChatMarker? status;
  Message(
      {required this.id,
      required this.type,
      this.fromId,
      this.fromName,
      this.toId,
      this.toName,
      required this.text,
      required this.roomId,
      required this.originality,
      this.attachment,
      this.thumbnail,
      this.originalId,
      this.originalMessage,
      this.size,
      this.mime,
      this.longitude,
      this.latitude,
      required this.sendTime,
      this.status});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}

class MessageTypeConverter extends TypeConverter<MessageType, String>{
  @override
  MessageType decode(String databaseValue) {
    return MessageType.values.byName(databaseValue);
  }

  @override
  String encode(MessageType value) {
    return value.name;
  }
}

class MessageOriginalityConverter extends TypeConverter<MessageOriginality, String> {
  @override
  MessageOriginality decode(String databaseValue) {
    return MessageOriginality.values.byName(databaseValue);
  }

  @override
  String encode(MessageOriginality value) {
    return value.name;
  }
}
class ChatMarkerConverter extends TypeConverter<ChatMarker?, String?> {
  @override
  ChatMarker? decode(String? databaseValue) {
    if(databaseValue != null) {
      return ChatMarker.values.byName(databaseValue);
    }
  }

  @override
  String? encode(ChatMarker? value) {
    if(value != null) {
      return value.name;
    }
  }
}