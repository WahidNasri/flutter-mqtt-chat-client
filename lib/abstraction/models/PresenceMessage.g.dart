// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PresenceMessage.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PresenceMessageCopyWith on PresenceMessage {
  PresenceMessage copyWith({
    String? fromId,
    String? fromName,
    String? id,
    PresenceType? presenceType,
    MessageType? type,
  }) {
    return PresenceMessage(
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      id: id ?? this.id,
      presenceType: presenceType ?? this.presenceType,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresenceMessage _$PresenceMessageFromJson(Map<String, dynamic> json) {
  return PresenceMessage(
    id: json['id'] as String,
    presenceType: _$enumDecode(_$PresenceTypeEnumMap, json['presenceType']),
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    fromId: json['fromId'] as String?,
    fromName: json['fromName'] as String?,
  );
}

Map<String, dynamic> _$PresenceMessageToJson(PresenceMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'presenceType': _$PresenceTypeEnumMap[instance.presenceType],
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

const _$PresenceTypeEnumMap = {
  PresenceType.Available: 'Available',
  PresenceType.Away: 'Away',
  PresenceType.Unavailable: 'Unavailable',
};

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
