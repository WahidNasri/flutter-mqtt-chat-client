import 'dart:async';
import 'dart:convert';

import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/MessageOnlineReaderHandler.dart';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMarkerMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/PresenceMesssage.dart';
import 'package:flutter_mqtt/abstraction/models/TypingMessage.dart';

class MqttOnlineReader extends MessageOnlineReaderHandler {
  ClientHandler clientHandler;
  StreamController<ChatMessage> _chatController = StreamController.broadcast();
  StreamController<PresenceMessage> _presenceController =
      StreamController.broadcast();
  StreamController<ChatMarkerMessage> _chatMarkerController =
      StreamController.broadcast();
  StreamController<TypingMessage> _typingController =
      StreamController.broadcast();
  MqttOnlineReader({
    required this.clientHandler,
  }) {
    clientHandler.allMessagesStream().listen((payloadWithTopic) {
      String payload = payloadWithTopic.payload;
      String topic = payloadWithTopic.topic;

      if (topic.toLowerCase().startsWith("archives")) {
        return;
      }
      Map<String, dynamic> payloadMap = jsonDecode(payload);

      if (topic.toLowerCase().startsWith("messages/")) {
        ChatMessage chatMessage = ChatMessage.fromJson(payload);
        _chatController.add(chatMessage);
      } else if (topic.toLowerCase().startsWith("presence/")) {
        PresenceMessage pMsg = PresenceMessage.fromJson(payload);
        _presenceController.add(pMsg);
      } else if (topic.toLowerCase().startsWith("events/")) {
        BaseMessage baseMsg = BaseMessage.fromJson(payloadMap);
        //handle rooms events
        //String roomId = topic.toLowerCase().split("/")[1];
        if (baseMsg.isChatMarkerEvent()) {
          ChatMarkerMessage cmMsg = ChatMarkerMessage.fromJson(payload);
          _chatMarkerController.add(cmMsg);
        } else if (baseMsg.isTypingEvent()) {
          TypingMessage tMsg = TypingMessage.fromJson(payload);
          _typingController.add(tMsg);
        }
      }
    });
  }

  @override
  Stream<ChatMessage> getChatMessages() {
    return _chatController.stream;
  }

  @override
  Stream<PresenceMessage> getPresenceMessages() {
    return _presenceController.stream;
  }

  @override
  Stream<ChatMarkerMessage> getChatMarkerMessages() {
    return _chatMarkerController.stream;
  }

  @override
  Stream<TypingMessage> getTypingMessages() {
    return _typingController.stream;
  }

  @override
  Future<void> dispose() async {
    final futures = <Future>[];

    if (!_chatController.isClosed) {
      futures.add(_chatController.close());
    }
    if (!_presenceController.isClosed) {
      futures.add(_presenceController.close());
    }
    if (!_typingController.isClosed) {
      futures.add(_typingController.close());
    }
    if (_chatMarkerController.isClosed) {
      futures.add(_chatMarkerController.close());
    }

    await Future.wait<dynamic>(futures);
  }
}
