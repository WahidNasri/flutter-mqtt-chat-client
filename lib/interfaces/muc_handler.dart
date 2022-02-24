import 'dart:io';

import 'package:flutter_chat_mqtt/models/room_member.dart';

abstract class MucHandler{
  void createGroup({required String name, required List<RoomMember> members, String? password});
  void removeGroup(String groupId);
  void addUsersToGroup(String groupId, List<RoomMember> members, bool showPreviousHistory);
  void removeUsersFromGroup(String groupId, List<RoomMember> members);
  void updateGroupInfo(String groupId, String newName, File avatar);
}