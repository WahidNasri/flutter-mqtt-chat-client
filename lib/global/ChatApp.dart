import 'package:flutter_mqtt/MqttImpl/FakeUploader.dart';
import 'package:flutter_mqtt/MqttImpl/MqttArchiveHandler.dart';
import 'package:flutter_mqtt/MqttImpl/MqttChatEventsSender.dart';
import 'package:flutter_mqtt/MqttImpl/MqttClient.dart';
import 'package:flutter_mqtt/MqttImpl/MqttMessageSender.dart';
import 'package:flutter_mqtt/MqttImpl/MqttOnlineReader.dart';
import 'package:flutter_mqtt/abstraction/ArchiveHandler.dart';
import 'package:flutter_mqtt/abstraction/ChatEventsSender.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/MessageOnlineReaderHandler.dart';
import 'package:flutter_mqtt/abstraction/MessageSender.dart';

class ChatApp {
  static ChatApp? _instance;

  late ClientHandler clientHandler;
  late MessageOnlineReaderHandler messageReader;
  late MessageSender messageSender;
  late ChatEventsSender eventsSender;
  late ArchiveHandler archiveHandler;

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
        clientHandler: clientHandler, uploader: FakeUploader());
    eventsSender = MqttChatEventsSender(clientHandler: clientHandler);
    archiveHandler = MqttArchiveHandler(clientHandler: clientHandler);
  }
  void disconnect() {
    clientHandler.disconnect();
    messageReader.dispose();
    archiveHandler.dispose();
  }
}
