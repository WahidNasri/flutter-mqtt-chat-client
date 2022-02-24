// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_membership_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomMembershipMessage _$RoomMembershipMessageFromJson(
        Map<String, dynamic> json) =>
    RoomMembershipMessage(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      roomId: json['roomId'] as String,
      avatar: json['avatar'] as String?,
      presenceType:
          $enumDecodeNullable(_$PresenceTypeEnumMap, json['presenceType']) ??
              PresenceType.available,
      isGroup: RoomMembershipMessage.boolFromJson(json['isGroup']),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => RoomMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      sendTime: BaseMessage.sendTimeFromJson(json['sendTime']),
    );

Map<String, dynamic> _$RoomMembershipMessageToJson(
        RoomMembershipMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendTime': instance.sendTime,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'roomId': instance.roomId,
      'avatar': instance.avatar,
      'presenceType': _$PresenceTypeEnumMap[instance.presenceType],
      'isGroup': instance.isGroup,
      'members': instance.members,
    };

const _$PresenceTypeEnumMap = {
  PresenceType.available: 'Available',
  PresenceType.away: 'Away',
  PresenceType.unavailable: 'Unavailable',
};
