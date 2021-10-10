import 'dart:convert';

import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ContactChat.g.dart';

@JsonSerializable()
@CopyWith()
class ContactChat {
  String firstName;
  String lastName;
  String id;
  String? avatar;
  String roomId;
  PresenceType? presence;
  bool? isGroup;
  ContactChat(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.avatar,
      required this.roomId,
      required this.isGroup,
      this.presence});

  factory ContactChat.fromJson(Map<String, dynamic> json) => _$ContactChatFromJson(json);
  factory ContactChat.fromString(String jsonString) => _$ContactChatFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ContactChatToJson(this);

}
