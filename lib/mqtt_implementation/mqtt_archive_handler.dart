import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqchat/extensions/topics_extensions.dart';
import 'package:flutter_mqchat/interfaces/archive_handler.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/models/room_membership_message.dart';
import 'package:flutter_mqchat/models/user.dart';

class MqttArchiveHandler extends ArchiveHandler {
  final ClientHandler clientHandler;
  final StreamController<List<RoomMembershipMessage>> _contactsController =
      StreamController.broadcast();
  final StreamController<User> _userController = StreamController.broadcast();
  MqttArchiveHandler({
    required this.clientHandler,
  }) {
    clientHandler.allMessagesStream().listen((payloadEvent) {
      String topic = payloadEvent.topic;
      String payload = payloadEvent.payload;
      if (topic.isMembershipArchivesTopic) {
        try {
          Iterable l = jsonDecode(payload);
          List<RoomMembershipMessage> contacts =
              List<RoomMembershipMessage>.from(
                  l.map((model) => RoomMembershipMessage.fromJson(model)));
          for (var contact in contacts) {
            //======================================//
            clientHandler.joinRoom(contact.roomId);
            clientHandler.joinContactEvents(contact.id);
            //======================================//
          }

          _contactsController.add(contacts);
        } catch (e) {
          debugPrint(e.toString());
        }
      } else if (topic.isMyProfileArchiveTopic) {
        User user = User.fromString(payload);
        clientHandler.joinMyEvents(user.id);
        _userController.add(user);
      }
    });
  }
  @override
  Stream<List<RoomMembershipMessage>> getAllConversations() {
    return _contactsController.stream;
  }

  @override
  Future<void> dispose() async {
    _contactsController.close();
  }

  @override
  Stream<User> getUser() {
    return _userController.stream;
  }
}
