import 'dart:io';

import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_mqchat/models/payload_with_topic.dart';

abstract class ClientHandler {
  Future<bool> connect(
      {required host,
      required String username,
      required String password,
      String? clientId,
      int? port});
  void disconnect();
  bool isConnected();
  bool isConnecting();

  String? getClientId();
  void joinRoom(String bareRoom); //similar to subscribe to topic
  void joinContactEvents(String contactId);
  void joinMyEvents(String myId);
  void leaveRoom(String bareRoom);
  void leaveContactEvents(String contactId);
  void sendPayload(String payload, String channel);
  void sendFilePayload(File file, String channel);

  Stream<PayloadWithTopic> allMessagesStream();
  Stream<ConnectionState> connectionStateStream();
}
