import 'dart:async';

import 'package:flutter_chat_mqtt/extensions/topics_extensions.dart';
import 'package:flutter_chat_mqtt/interfaces/client_handler.dart';
import 'package:flutter_chat_mqtt/interfaces/message_global_reader.dart';
import 'package:flutter_chat_mqtt/models/base_message.dart';
import 'package:flutter_chat_mqtt/models/chat_marker_message.dart';
import 'package:flutter_chat_mqtt/models/chat_message.dart';
import 'package:flutter_chat_mqtt/models/presence_message.dart';
import 'package:flutter_chat_mqtt/models/typing_indicator_message.dart';

class MqttGlobalReader extends MessageGlobalReader {
  ClientHandler clientHandler;
  final StreamController<ChatMessage> _chatController =
      StreamController.broadcast();
  final StreamController<PresenceMessage> _presenceController =
      StreamController.broadcast();
  final StreamController<ChatMarkerMessage> _chatMarkerController =
      StreamController.broadcast();
  final StreamController<TypingIndicatorMessage> _typingController =
      StreamController.broadcast();
  MqttGlobalReader({
    required this.clientHandler,
  }) {
    clientHandler.allMessagesStream().listen((payloadWithTopic) {
      String payload = payloadWithTopic.payload;
      String topic = payloadWithTopic.topic;

      if (topic.isChattingTopic) {
        ChatMessage chatMessage = ChatMessage.fromString(payload);
        _chatController.add(chatMessage);
      } else if (topic.isPresenceTopic) {
        PresenceMessage pMsg = PresenceMessage.fromString(payload);
        _presenceController.add(pMsg);
      } else if (topic.isRoomEventsTopic) {
        BaseMessage baseMsg = BaseMessage.fromString(payload);
        //handle rooms events
        //String roomId = topic.toLowerCase().split("/")[1];
        if (baseMsg.isChatMarkerEvent()) {
          ChatMarkerMessage cmMsg = ChatMarkerMessage.fromString(payload);
          _chatMarkerController.add(cmMsg);
        } else if (baseMsg.isTypingEvent()) {
          TypingIndicatorMessage tMsg =
              TypingIndicatorMessage.fromString(payload);
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
  Stream<TypingIndicatorMessage> getTypingMessages() {
    return _typingController.stream;
  }

  @override
  Future<void> dispose() async {
    //TODO: Find a better way to dispose
    /*
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

     */
  }
}
