import 'package:flutter_chat_mqtt/models/base_message.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:flutter_chat_mqtt/models/room_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_membership_message.g.dart';

@JsonSerializable()
//@CopyWith()
class RoomMembershipMessage extends BaseMessage {
  final String? firstName;
  final String? lastName;
  final String roomId;
  final String? avatar;
  final PresenceType presenceType;
  @JsonKey(fromJson: boolFromJson)
  final bool isGroup;
  final List<RoomMember>? members;

  RoomMembershipMessage(
      {required String id,
      this.firstName,
      this.lastName,
      required this.roomId,
      this.avatar, this.presenceType = PresenceType.available,
        required this.isGroup,
      this.members,
      int? sendTime})
      : super(id: id, type: MessageType.membership, fromId: '', fromName: '', sendTime: sendTime);

  factory RoomMembershipMessage.fromJson(Map<String, dynamic> json) =>
      _$RoomMembershipMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoomMembershipMessageToJson(this);

  static bool boolFromJson(dynamic value){
    if(value == null){
      return false;
    }
    if(value is String){
      return value.toLowerCase() == "true";
    }
    else if(value is bool){
      return value;
    }
    else if(value is int){
      return value > 0;
    }
    return false;
  }
}
