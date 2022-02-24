// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_indicator_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypingIndicatorMessage _$TypingIndicatorMessageFromJson(
        Map<String, dynamic> json) =>
    TypingIndicatorMessage(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      isTyping: TypingIndicatorMessage.boolFromJson(json['isTyping']),
      roomId: json['roomId'] as String,
      fromId: json['fromId'] as String?,
      fromName: json['fromName'] as String?,
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
    );

Map<String, dynamic> _$TypingIndicatorMessageToJson(
        TypingIndicatorMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'sendTime': instance.sendTime,
      'isTyping': instance.isTyping,
      'roomId': instance.roomId,
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
