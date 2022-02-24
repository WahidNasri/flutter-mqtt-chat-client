// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseMessage _$BaseMessageFromJson(Map<String, dynamic> json) => BaseMessage(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      fromId: json['fromId'] as String?,
      fromName: json['fromName'] as String?,
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
    );

Map<String, dynamic> _$BaseMessageToJson(BaseMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'sendTime': instance.sendTime,
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
