import 'dart:convert';

import 'package:flutter_mqchat/models/base_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_mqchat/models/room_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_crud_message.g.dart';

@JsonSerializable()
//@CopyWith()
class GroupCrudMessage extends BaseMessage {
  final String name;
  final List<RoomMember> members;

  GroupCrudMessage(
      {required String id,
      required MessageType type,
      required this.name,
      required this.members,
      int? sendTime})
      : super(id: id, type: type);

  factory GroupCrudMessage.fromJson(Map<String, dynamic> json) =>
      _$GroupCrudMessageFromJson(json);
  factory GroupCrudMessage.fromString(String payload) =>
      GroupCrudMessage.fromJson(json.decode(payload));

  @override
  Map<String, dynamic> toJson() => _$GroupCrudMessageToJson(this);
}
