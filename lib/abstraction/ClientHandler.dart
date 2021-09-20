import 'dart:io';

import 'package:flutter_mqtt/abstraction/models/PayloadWithTopic.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';

abstract class ClientHandler {
  Future<bool> connect(
      {required String username, required String password, String? clientId});
  void disconnect();
  bool isConnected();
  bool isConnecting();

  String? getClientId();
  void joinRoom(String room); //similar to subscribe to topic
  void joinContactEvents(String contactId);
  void joinMyEvents(String myId);
  void leaveRoom(String bareRoom);
  void leaveContactEvents(String contactId);
  void sendPayload(String payload, String channel);
  void sendFilePayload(File file, String channel);

  Stream<PayloadWithTopic> allMessagesStream();
  Stream<ConnectionState> connectionStateStream();
}
