import 'package:flutter_mqchat/models/chat_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:uuid/uuid.dart';

abstract class MessageSender {
  MessageSender();

  void sendChatMessage(ChatMessage message, String bareRoom);
  void sendFileChatMessage(
      {required MessageType type,
      required String fileLocalPath,
      required String room});

  void forwardChatMessage(
      ChatMessage toForwardMessage, String toId, String toName, String toRoom) {
    ChatMessage newMessage = toForwardMessage.copyWith(
        originalId: toForwardMessage.id,
        originalMessage: toForwardMessage.text,
        originality: MessageOriginality.forward,
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
        originality: MessageOriginality.reply);
    sendChatMessage(toSendMessage, room);
  }

  void sendLocationMessage(
      double longitude, double latitude, String? address, String room) {
    ChatMessage message = ChatMessage(
        id: const Uuid().v4(),
        type: MessageType.chatLocation,
        text: address ?? "",
        roomId: room,
        longitude: longitude,
        latitude: latitude,
        originality: MessageOriginality.original,
        sendTime: DateTime.now().millisecondsSinceEpoch);

    sendChatMessage(message, room);
  }
}
