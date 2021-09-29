import 'dart:io';

abstract class MucHandler{
  void createGroup(String name, List<String> members, String? password);
  void removeGroup(String groupId);
  void addUsersToGroup(String groupId, List<String> userIds, bool showPreviousHistory);
  void removeUsersFromGroup(String groupId, List<String> memberIds);
  void updateGroupInfo(String groupId, String newName, File avatar);
}