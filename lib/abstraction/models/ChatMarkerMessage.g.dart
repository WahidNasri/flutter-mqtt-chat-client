// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMarkerMessage.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ChatMarkerMessageCopyWith on ChatMarkerMessage {
  ChatMarkerMessage copyWith({
    String? fromId,
    String? id,
    String? referenceId,
    String? roomId,
    ChatMarker? status,
    MessageType? type,
  }) {
    return ChatMarkerMessage(
      fromId: fromId ?? this.fromId,
      id: id ?? this.id,
      referenceId: referenceId ?? this.referenceId,
      roomId: roomId ?? this.roomId,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMarkerMessage _$ChatMarkerMessageFromJson(Map<String, dynamic> json) {
  return ChatMarkerMessage(
    id: json['id'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    fromId: json['fromId'] as String,
    roomId: json['roomId'] as String?,
    referenceId: json['referenceId'] as String,
    status: _$enumDecode(_$ChatMarkerEnumMap, json['status']),
  );
}

Map<String, dynamic> _$ChatMarkerMessageToJson(ChatMarkerMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'roomId': instance.roomId,
      'referenceId': instance.referenceId,
      'status': _$ChatMarkerEnumMap[instance.status],
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

const _$ChatMarkerEnumMap = {
  ChatMarker.sent: 'sent',
  ChatMarker.delivered: 'delivered',
  ChatMarker.displayed: 'displayed',
};
