import 'dart:convert';
import 'dart:io';

import 'package:flutter_mqchat/extensions/topics_extensions.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/interfaces/message_sender.dart';
import 'package:flutter_mqchat/models/chat_message.dart';
import 'package:flutter_mqchat/models/enums.dart';

class MqttMessageSender extends MessageSender {
  ClientHandler clientHandler;
  MqttMessageSender({required this.clientHandler}) : super();

  @override
  void sendChatMessage(ChatMessage message, String bareRoom) {
    var messagePayload = jsonEncode(message.toJson());

    String chatTopic = bareRoom.toChattingTopic;
    clientHandler.sendPayload(messagePayload, chatTopic);
  }

  @override
  void sendFileChatMessage(
      {required MessageType type,
      required String fileLocalPath,
      required String room}) {
    File file = File(fileLocalPath);
    String fileChatTopic = room.toFileSendingTopic;
    clientHandler.sendFilePayload(file, fileChatTopic);
  }
}
