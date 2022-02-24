import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'room_member.g.dart';

@JsonSerializable()
//@CopyWith()
class RoomMember {
  final String id;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String? avatar;

  RoomMember(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.avatar});

  factory RoomMember.fromJson(Map<String, dynamic> json) =>
      _$RoomMemberFromJson(json);
  factory RoomMember.fromString(String payload) => RoomMember.fromJson(json.decode(payload));

  Map<String, dynamic> toJson() => _$RoomMemberToJson(this);
}
