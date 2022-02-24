import 'dart:io';

import 'package:flutter_chat_mqtt/extensions/topics_extensions.dart';
import 'package:flutter_chat_mqtt/interfaces/client_handler.dart';
import 'package:flutter_chat_mqtt/interfaces/muc_handler.dart';
import 'package:flutter_chat_mqtt/models/chat_message.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
import 'package:flutter_chat_mqtt/models/group_crud_message.dart';
import 'package:flutter_chat_mqtt/models/room_member.dart';
import 'package:uuid/uuid.dart';

class MqttMucHandler extends MucHandler {
  final ClientHandler clientHandler;

  MqttMucHandler(this.clientHandler);
  @override
  void addUsersToGroup(
      String groupId, List<RoomMember> members, bool showPreviousHistory) {
    GroupCrudMessage msg = GroupCrudMessage(
        id: groupId,
        type: MessageType.addGroup,
        name: '',
        sendTime: 0,
        members: members);

    String topic = groupId.toGroupCrudTopic;
    clientHandler.sendPayload(msg.toJson().toString(), topic);
  }

  @override
  void createGroup(
      {required String name, required List<RoomMember> members, String? password}) {
    String id = const Uuid().v4();
    GroupCrudMessage msg = GroupCrudMessage(
        id: id,
        type: MessageType.addGroup,
        name: name,
        sendTime: 0,
        members: members);

    String topic = id.toGroupCrudTopic;
    clientHandler.sendPayload(msg.toJson().toString(), topic);
  }

  @override
  void removeGroup(String groupId) {
    ChatMessage msg = ChatMessage(
        id: groupId,
        type: MessageType.removeGroup,
        text: groupId,
        roomId: '',
        sendTime: 0);

    String topic = groupId.toGroupCrudTopic;
    clientHandler.sendPayload(msg.toJson().toString(), topic);
  }

  @override
  void removeUsersFromGroup(String groupId, List<RoomMember> members) {
    throw UnimplementedError("NOT IMPLEMENTED YET");
  }

  @override
  void updateGroupInfo(String groupId, String newName, File avatar) {
    throw UnimplementedError("NOT IMPLEMENTED YET");
  }
}
