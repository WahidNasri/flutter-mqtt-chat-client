import 'dart:convert';
import 'dart:io';

import 'package:flutter_mqtt/MqttImpl/topics_generator.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/FileUploader.dart';
import 'package:flutter_mqtt/abstraction/MessageSender.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';

class MqttMessageSender extends MessageSender {
  ClientHandler clientHandler;
  FileUploader uploader;
  MqttMessageSender({required this.clientHandler, required this.uploader})
      : super(uploader);

  @override
  void sendChatMessage(ChatMessage message, String bareRoom) {
    var messagePayload = jsonEncode(message.toMap());

    String chatTopic =
        TopicsNamesGenerator.getChattingTopicForBareRoom(bareRoom);
    clientHandler.sendPayload(messagePayload, chatTopic);
  }

  @override
  void sendFileChatMessage(
      {required MessageType type,
      required String fileLocalPath,
      required String room}) {
    File file = File(fileLocalPath);
    String fileChatTopic =
        TopicsNamesGenerator.getFileChattingTopicForBareRoom(room);
    clientHandler.sendFilePayload(file, fileChatTopic);
  }
}
