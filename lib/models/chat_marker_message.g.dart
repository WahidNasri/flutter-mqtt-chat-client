// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_marker_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMarkerMessage _$ChatMarkerMessageFromJson(Map<String, dynamic> json) =>
    ChatMarkerMessage(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      referenceId: json['referenceId'] as String,
      fromId: json['fromId'] as String?,
      fromName: json['fromName'] as String?,
      roomName: json['roomName'] as String?,
      status: $enumDecode(_$ChatMarkerEnumMap, json['status']),
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
    );

Map<String, dynamic> _$ChatMarkerMessageToJson(ChatMarkerMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'sendTime': instance.sendTime,
      'referenceId': instance.referenceId,
      'roomName': instance.roomName,
      'status': _$ChatMarkerEnumMap[instance.status],
    };

const _$MessageTypeEnumMap = {
  MessageType.chatText: 'ChatText',
  MessageType.chatImage: 'ChatImage',
  MessageType.chatVideo: 'ChatVideo',
  MessageType.chatAudio: 'ChatAudio',
  MessageType.chatDocument: 'ChatDocument',
  MessageType.chatLocation: 'ChatLocation',
  MessageType.chatContact: 'ChatContact',
  MessageType.invitationRequest: 'InvitationRequest',
  MessageType.invitationResponseAccept: 'InvitationResponseAccept',
  MessageType.invitationResponseReject: 'InvitationResponseReject',
  MessageType.presence: 'Presence',
  MessageType.chatMarker: 'ChatMarker',
  MessageType.typing: 'Typing',
  MessageType.membership: 'Membership',
  MessageType.addGroup: 'AddGroup',
  MessageType.removeGroup: 'RemoveGroup',
};

const _$ChatMarkerEnumMap = {
  ChatMarker.sent: 'sent',
  ChatMarker.delivered: 'delivered',
  ChatMarker.displayed: 'displayed',
};
