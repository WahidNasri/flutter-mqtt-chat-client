// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomMember _$RoomMemberFromJson(Map<String, dynamic> json) => RoomMember(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$RoomMemberToJson(RoomMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
    };
