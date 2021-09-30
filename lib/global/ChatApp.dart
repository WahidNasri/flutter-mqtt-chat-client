import 'package:flutter_mqtt/MqttImpl/MqttArchiveHandler.dart';
import 'package:flutter_mqtt/MqttImpl/MqttChatEventsSender.dart';
import 'package:flutter_mqtt/MqttImpl/MqttClient.dart';
import 'package:flutter_mqtt/MqttImpl/MqttInvitationHandler.dart';
import 'package:flutter_mqtt/MqttImpl/MqttMessageSender.dart';
import 'package:flutter_mqtt/MqttImpl/MqttMucHandler.dart';
import 'package:flutter_mqtt/MqttImpl/MqttOnlineReader.dart';
import 'package:flutter_mqtt/abstraction/ArchiveHandler.dart';
import 'package:flutter_mqtt/abstraction/ChatEventsSender.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/InvitationsHandler.dart';
import 'package:flutter_mqtt/abstraction/MessageOnlineReaderHandler.dart';
import 'package:flutter_mqtt/abstraction/MessageSender.dart';
import 'package:flutter_mqtt/abstraction/MucHandler.dart';

class ChatApp {
  static ChatApp? _instance;

  late ClientHandler clientHandler;
  late MessageOnlineReaderHandler messageReader;
  late MessageSender messageSender;
  late ChatEventsSender eventsSender;
  late ArchiveHandler archiveHandler;
  late InvitationHandler invitationHandler;
  late MucHandler mucHandler;

  static ChatApp? instance() {
    if (_instance == null) {
      _instance = ChatApp._();
    }
    return _instance;
  }

  ChatApp._() {
    clientHandler = MqttClient();
    messageReader = MqttOnlineReader(clientHandler: clientHandler);
    messageSender = MqttMessageSender(
        clientHandler: clientHandler);
    eventsSender = MqttChatEventsSender(clientHandler: clientHandler);
    archiveHandler = MqttArchiveHandler(clientHandler: clientHandler);
    invitationHandler = MqttInvitationHandler(clientHandler);
    mucHandler = MqttMucHandler(clientHandler);
  }
  void disconnect() {
    clientHandler.disconnect();
    messageReader.dispose();
    archiveHandler.dispose();
  }
}
