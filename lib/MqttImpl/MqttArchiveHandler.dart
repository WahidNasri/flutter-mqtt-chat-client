import 'dart:async';
import 'dart:convert';

import 'package:flutter_mqtt/abstraction/ArchiveHandler.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';

class MqttArchiveHandler extends ArchiveHandler {
  final ClientHandler clientHandler;
  StreamController<List<ContactChat>> _contactsController =
      StreamController.broadcast();
  StreamController<User> _userController = StreamController.broadcast();
  MqttArchiveHandler({
    required this.clientHandler,
  }) {
    clientHandler.allMessagesStream().listen((payloadEvent) {
      String topic = payloadEvent.topic;
      String payload = payloadEvent.payload;
      if (topic.toLowerCase().startsWith("archivesrooms/")) {
        try {
          Iterable l = jsonDecode(payload);
          List<ContactChat> contacts = List<ContactChat>.from(
              l.map((model) => ContactChat.fromMap(model)));
          for (var contact in contacts) {
            //======================================//
            clientHandler.joinRoom(contact.roomId);
            clientHandler.joinContactEvents(contact.id);
            //======================================//
          }

          _contactsController.add(contacts);
        } catch (e) {
          print(e);
        }
      } else if (topic.toLowerCase().startsWith("archivesmyid/")) {
        User user = User.fromJson(payload);
        _userController.add(user);
      }
    });
  }
  @override
  Stream<List<ContactChat>> getAllConversations() {
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
