import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/db/database.dart';

import 'package:flutter_mqtt/db/appdata/extensions/MessagesExtensions.dart';

class MessagesHandler {
  Stream<List<ChatMessage>> getMessagesByRoomId(String bareRoom) {
    return MyDatabase.instance()!.messageDao.getMessagesByRoomId(bareRoom).map(
        (dbMessages) => dbMessages.map((dm) => dm.toChatMessage()).toList());
  }

  Stream<List<ChatMessage>> getAllMessages() {
    return MyDatabase.instance()!.messageDao.getAllMessages().map(
        (dbMessages) => dbMessages.map((dm) => dm.toChatMessage()).toList());
  }

  void addMessage(ChatMessage chatmessage) {
    MyDatabase.instance()!.messageDao.addMessage(chatmessage.toDbMessage());
  }

  Future deleteAll() {
    return MyDatabase.instance()!.messageDao.deleteAllMessages();
  }
}
