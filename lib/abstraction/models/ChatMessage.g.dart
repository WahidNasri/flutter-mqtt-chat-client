// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessage.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ChatMessageCopyWith on ChatMessage {
  ChatMessage copyWith({
    List<String>? additionalFields,
    String? attachment,
    String? fromId,
    String? fromName,
    String? id,
    double? latitude,
    double? longitude,
    String? mime,
    String? originalId,
    String? originalMessage,
    MessageOriginality? originality,
    String? roomId,
    int? sendTime,
    int? size,
    String? text,
    String? thumbnail,
    String? toId,
    String? toName,
    MessageType? type,
  }) {
    return ChatMessage(
      additionalFields: additionalFields ?? this.additionalFields,
      attachment: attachment ?? this.attachment,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      mime: mime ?? this.mime,
      originalId: originalId ?? this.originalId,
      originalMessage: originalMessage ?? this.originalMessage,
      originality: originality ?? this.originality,
      roomId: roomId ?? this.roomId,
      sendTime: sendTime ?? this.sendTime,
      size: size ?? this.size,
      text: text ?? this.text,
      thumbnail: thumbnail ?? this.thumbnail,
      toId: toId ?? this.toId,
      toName: toName ?? this.toName,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    id: json['id'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    fromId: json['fromId'] as String?,
    fromName: json['fromName'] as String?,
    toId: json['toId'] as String?,
    toName: json['toName'] as String?,
    text: json['text'] as String,
    roomId: json['roomId'] as String,
    originality: _$enumDecode(_$MessageOriginalityEnumMap, json['originality']),
    attachment: json['attachment'] as String?,
    thumbnail: json['thumbnail'] as String?,
    originalId: json['originalId'] as String?,
    originalMessage: json['originalMessage'] as String?,
    sendTime: ChatMessage._sendTimeFromJson(json['sendTime']),
    size: json['size'] as int?,
    mime: json['mime'] as String?,
    additionalFields: (json['additionalFields'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    longitude: ChatMessage._latLngFromJson(json['longitude']),
    latitude: ChatMessage._latLngFromJson(json['latitude']),
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'toId': instance.toId,
      'toName': instance.toName,
      'text': instance.text,
      'roomId': instance.roomId,
      'originality': _$MessageOriginalityEnumMap[instance.originality],
      'attachment': instance.attachment,
      'thumbnail': instance.thumbnail,
      'originalId': instance.originalId,
      'originalMessage': instance.originalMessage,
      'sendTime': instance.sendTime,
      'size': instance.size,
      'mime': instance.mime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'additionalFields': instance.additionalFields,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MessageTypeEnumMap = {
  MessageType.ChatText: 'ChatText',
  MessageType.ChatImage: 'ChatImage',
  MessageType.ChatVideo: 'ChatVideo',
  MessageType.ChatAudio: 'ChatAudio',
  MessageType.ChatDocument: 'ChatDocument',
  MessageType.ChatLocation: 'ChatLocation',
  MessageType.ChatContact: 'ChatContact',
  MessageType.EventInvitationRequest: 'EventInvitationRequest',
  MessageType.EventInvitationResponseAccept: 'EventInvitationResponseAccept',
  MessageType.EventInvitationResponseReject: 'EventInvitationResponseReject',
  MessageType.Presence: 'Presence',
  MessageType.ChatMarker: 'ChatMarker',
  MessageType.Typing: 'Typing',
  MessageType.CreateGroup: 'CreateGroup',
  MessageType.RemoveGroup: 'RemoveGroup',
  MessageType.AddUsersToGroup: 'AddUsersToGroup',
  MessageType.RemoveGroupMembers: 'RemoveGroupMembers',
};

const _$MessageOriginalityEnumMap = {
  MessageOriginality.Original: 'Original',
  MessageOriginality.Reply: 'Reply',
  MessageOriginality.Forward: 'Forward',
};
