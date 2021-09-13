import 'package:flutter_mqtt/MqttImpl/topics_generator.dart';
import 'package:flutter_mqtt/abstraction/ChatEventsSender.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMarkerMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ChatMarker.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:flutter_mqtt/abstraction/models/TypingMessage.dart';
import 'package:uuid/uuid.dart';

class MqttChatEventsSender extends ChatEventsSender {
  final ClientHandler clientHandler;

  MqttChatEventsSender({required this.clientHandler});
  @override
  void sendChatMarker(String messageId, ChatMarker marker, String bareRoom) {
    String topic = TopicsNamesGenerator.getEventsTopicForBareRoom(bareRoom);

    ChatMarkerMessage msg = ChatMarkerMessage(id: Uuid().v4(), type: MessageType.ChatMarker, fromId: "", referenceId: messageId, status: marker);
    clientHandler.sendPayload(msg.toJson(), topic);
  }

  @override
  void sendIsTyping(bool isTyping, String bareRoom) {
    TypingMessage message = TypingMessage(
        id: Uuid().v4(),
        type: MessageType.Typing,
        fromId: Uuid().v1(), //TODO: use user id
        roomId: bareRoom,
        isTyping: isTyping);

    String topic = TopicsNamesGenerator.getEventsTopicForBareRoom(bareRoom);
    clientHandler.sendPayload(message.toJson(), topic);
  }
}
