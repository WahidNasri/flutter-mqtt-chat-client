// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvitationMessage.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension InvitationMessageCopyWith on InvitationMessage {
  InvitationMessage copyWith({
    String? fromAvatar,
    String? fromId,
    String? fromName,
    String? id,
    InvitationMessageType? invitationMessageType,
    int? sendTime,
    String? text,
    MessageType? type,
  }) {
    return InvitationMessage(
      fromAvatar: fromAvatar ?? this.fromAvatar,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      id: id ?? this.id,
      invitationMessageType:
          invitationMessageType ?? this.invitationMessageType,
      sendTime: sendTime ?? this.sendTime,
      text: text ?? this.text,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationMessage _$InvitationMessageFromJson(Map<String, dynamic> json) {
  return InvitationMessage(
    id: json['id'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    invitationMessageType: _$enumDecode(
        _$InvitationMessageTypeEnumMap, json['invitationMessageType']),
    text: json['text'] as String?,
    fromId: json['fromId'] as String?,
    fromName: json['fromName'] as String?,
    fromAvatar: json['fromAvatar'] as String?,
    sendTime: json['sendTime'] as int,
  );
}

Map<String, dynamic> _$InvitationMessageToJson(InvitationMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'invitationMessageType':
          _$InvitationMessageTypeEnumMap[instance.invitationMessageType],
      'text': instance.text,
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'fromAvatar': instance.fromAvatar,
      'sendTime': instance.sendTime,
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

const _$InvitationMessageTypeEnumMap = {
  InvitationMessageType.REQUEST_RESPONSE: 'REQUEST_RESPONSE',
  InvitationMessageType.ERROR: 'ERROR',
  InvitationMessageType.INFO: 'INFO',
};
