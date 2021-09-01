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
  //TODO: handle showing message until it's uploaded and sent
  void sendFileChatMessage(
      {required String uploadUrl,
      required MessageType type,
      required String fileLocalPath,
      required String fromId,
      required String toId,
      required String fromName,
      required String room}) {
    String id = Uuid().v4();
    //===================

    ChatMessage message = ChatMessage(
        id: id,
        type: type,
        text: "File",
        roomId: room,
        attachment: fileLocalPath,
        fromId: fromId,
        fromName: fromName,
        toId: toId,
        sendTime: DateTime.now().millisecondsSinceEpoch,
        originality: MessageOriginality.Original);

    sendChatMessage(message, room);
    //===================
    uploader.uploadFile(uploadUrl, fileLocalPath).then((downloadUrl) {
      if (downloadUrl != null) {
        ChatMessage message = ChatMessage(
            id: id,
            type: type,
            text: "File",
            roomId: room,
            attachment: downloadUrl,
            fromId: fromId,
            fromName: fromName,
            toId: toId,
            sendTime: DateTime.now().millisecondsSinceEpoch,
            originality: MessageOriginality.Original);

        sendChatMessage(message, room);
      }
    });
  }

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
