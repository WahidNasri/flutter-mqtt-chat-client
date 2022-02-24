// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      fromId: json['fromId'] as String?,
      fromName: json['fromName'] as String?,
      toId: json['toId'] as String?,
      toName: json['toName'] as String?,
      text: json['text'] as String,
      roomId: json['roomId'] as String,
      originality: $enumDecodeNullable(
              _$MessageOriginalityEnumMap, json['originality']) ??
          MessageOriginality.original,
      attachment: json['attachment'] as String?,
      thumbnail: json['thumbnail'] as String?,
      originalId: json['originalId'] as String?,
      originalMessage: json['originalMessage'] as String?,
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
      size: json['size'] as int?,
      mime: json['mime'] as String?,
      longitude: ChatMessage._latLngFromJson(json['longitude']),
      latitude: ChatMessage._latLngFromJson(json['latitude']),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'fromId': instance.fromId,
      'fromName': instance.fromName,
      'sendTime': instance.sendTime,
      'toId': instance.toId,
      'toName': instance.toName,
      'text': instance.text,
      'roomId': instance.roomId,
      'originality': _$MessageOriginalityEnumMap[instance.originality],
      'attachment': instance.attachment,
      'thumbnail': instance.thumbnail,
      'originalId': instance.originalId,
      'originalMessage': instance.originalMessage,
      'size': instance.size,
      'mime': instance.mime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
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

const _$MessageOriginalityEnumMap = {
  MessageOriginality.original: 'Original',
  MessageOriginality.reply: 'Reply',
  MessageOriginality.forward: 'Forward',
};
