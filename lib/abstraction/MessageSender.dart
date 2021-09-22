import 'dart:io';

import 'package:uuid/uuid.dart';

import 'package:flutter_mqtt/abstraction/FileUploader.dart';

import 'models/ChatMessage.dart';
import 'models/enums/MessageOriginality.dart';
import 'models/enums/MessageType.dart';

abstract class MessageSender {
  FileUploader uploader;
  MessageSender(
    this.uploader,
  );

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
        toName: toName);
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
}
