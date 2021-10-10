// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseMessage.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BaseMessageCopyWith on BaseMessage {
  BaseMessage copyWith({
    String? fromId,
    String? fromName,
    String? id,
    MessageType? type,
  }) {
    return BaseMessage(
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseMessage _$BaseMessageFromJson(Map<String, dynamic> json) {
  return BaseMessage(
    id: json['id'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    fromId: json['fromId'] as String?,
    fromName: json['fromName'] as String?,
  );
}

Map<String, dynamic> _$BaseMessageToJson(BaseMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
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
