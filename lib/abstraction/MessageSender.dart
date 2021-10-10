import 'dart:io';

import 'package:uuid/uuid.dart';

import 'models/ChatMessage.dart';
import 'models/enums/MessageOriginality.dart';
import 'models/enums/MessageType.dart';

abstract class MessageSender {
  MessageSender();

  void sendChatMessage(ChatMessage message, String room);
  void sendFileChatMessage(
      {required MessageType type,
      required String fileLocalPath,
      required String room});

  void forwardChatMessage(
      ChatMessage toForwardMessage, String toId, String toName, String toRoom) {
    ChatMessage newMessage = toForwardMessage.copyWith(
        originalId: toForwardMessage.id,
        originalMessage: toForwardMessage.text,
        originality: MessageOriginality.Forward,
        toId: toId,
        toName: toName,
        sendTime: DateTime.now().millisecondsSinceEpoch);
    sendChatMessage(newMessage, toRoom);
  }

  void replyToMessage(
      ChatMessage originalMessage, ChatMessage newMessage, String room) {
    ChatMessage toSendMessage = newMessage.copyWith(
        originalId: originalMessage.id,
        originalMessage: originalMessage.text,
        originality: MessageOriginality.Reply);
    sendChatMessage(toSendMessage, room);
  }

  void sendLocationMessage(
      double longitude, double latitude, String? address, String room) {
    ChatMessage message = ChatMessage(
        id: Uuid().v4(),
        type: MessageType.ChatLocation,
        text: address ?? "",
        roomId: room,
        originality: MessageOriginality.Original,
        sendTime: DateTime.now().millisecondsSinceEpoch);

    sendChatMessage(message, room);
  }
}
