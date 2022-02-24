// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_crud_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupCrudMessage _$GroupCrudMessageFromJson(Map<String, dynamic> json) =>
    GroupCrudMessage(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      name: json['name'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => RoomMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
    );

Map<String, dynamic> _$GroupCrudMessageToJson(GroupCrudMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'sendTime': instance.sendTime,
      'name': instance.name,
      'members': instance.members,
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
