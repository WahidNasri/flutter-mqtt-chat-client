import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/db/database.dart';

import 'package:flutter_mqtt/db/appdata/extensions/MessagesExtensions.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
import 'package:rxdart/rxdart.dart';

class MessagesHandler {
  Stream<List<DbMessage>> getMessagesByRoomId(String bareRoom) {
    return MyDatabase.instance()!.messageDao.getMessagesByRoomId(bareRoom);
  }

  Stream<int> getUnseenMessagesCountByRoomId(String roomId) {
    return MyDatabase.instance()!
        .messageDao
        .getUnseenMessagesByRoomId(roomId)
        .map((msgs) => msgs.length);
  }

  Stream<List<ChatMessage>> getAllMessages() {
    return MyDatabase.instance()!.messageDao.getAllMessages().map(
        (dbMessages) => dbMessages.map((dm) => dm.toChatMessage()).toList());
  }

  Stream<List<ChatMessage>> getMediaMessagesByRoomId(String roomId) {
    return MyDatabase.instance()!
        .messageDao
        .getMediaMessagesByRoomId(roomId)
        .map((dbMessages) =>
            dbMessages.map((dm) => dm.toChatMessage()).toList());
  }

  void addMessage(ChatMessage chatmessage) {
    MyDatabase.instance()!.messageDao.addMessage(chatmessage.toDbMessage());
  }

  Stream<List<ExtendedDbContact>> getRecentMessages() {
    return MyDatabase.instance()!.messageDao.getConversations();
  }

  Future deleteAll() {
    return MyDatabase.instance()!.messageDao.deleteAllMessages();
  }
}
