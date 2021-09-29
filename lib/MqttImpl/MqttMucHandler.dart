import 'dart:io';

import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/MucHandler.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:uuid/uuid.dart';

class MqttMucHandler extends MucHandler{
  final ClientHandler clientHandler;

  MqttMucHandler(this.clientHandler);
  @override
  void addUsersToGroup(String groupId, List<String> userIds, bool showPreviousHistory) {
    ChatMessage msg = ChatMessage(id: groupId, type: MessageType.AddUsersToGroup, text: '', roomId: '', sendTime: 0, additionalFields: userIds);

    String topic = "muc/" + groupId;
    clientHandler.sendPayload(msg.toMap().toString(), topic);
  }

  @override
  void createGroup(String name, List<String> membersIds, String? password) {
    String id = Uuid().v4();
    ChatMessage msg = ChatMessage(id: id, type: MessageType.CreateGroup, text: name, roomId: '', sendTime: 0, additionalFields: membersIds);

    String topic = "muc/" + id;
    clientHandler.sendPayload(msg.toMap().toString(), topic);
  }

  @override
  void removeGroup(String groupId) {
    ChatMessage msg = ChatMessage(id: groupId, type: MessageType.RemoveGroup, text: groupId, roomId: '', sendTime: 0);

    String topic = "muc/" + groupId;
    clientHandler.sendPayload(msg.toMap().toString(), topic);
  }

  @override
  void removeUsersFromGroup(String groupId, List<String> memberIds) {
    ChatMessage msg = ChatMessage(id: groupId, type: MessageType.RemoveGroupMembers, text: '', roomId: '', sendTime: 0, additionalFields: memberIds);

    String topic = "muc/" + groupId;
    clientHandler.sendPayload(msg.toMap().toString(), topic);

  }

  @override
  void updateGroupInfo(String groupId, String newName, File avatar) {
    // TODO: implement updateGroupInfo
  }
  
}