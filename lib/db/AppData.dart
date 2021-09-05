import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';

class AppData {
  static AppData? _instance;
  static AppData? instance() {
    if (_instance == null) {
      _instance = AppData();
    }
  }

  AppDate() {
    //================ROOMS================//
    ChatApp.instance()!.archiveHandler.getAllConversations().listen((rooms) {
      var list = rooms.map((e) => DbContact.fromJson(e.toMap())).toList();
      for (var ctc in list) {
        MyDatabase().contactDao.addContact(ctc);
      }
    });

    //================User================//
    ChatApp.instance()!.archiveHandler.getUser().listen((user) {
      DbUser dbUser = DbUser.fromJson(user.toMap());
      MyDatabase()
          .userDao
          .deleteAllUsers()
          .then((value) => MyDatabase().userDao.addUser(dbUser))
          .then((value) => MyDatabase()
              .userDao
              .setClientId(ChatApp.instance()!.clientHandler.getClientId()!));
    });

    //===============Messages============//
    ChatApp.instance()!.messageReader.getChatMessages().listen((message) {
      DbMessage msg = DbMessage.fromJson(message.toMap());
      MyDatabase().messageDao.addMessage(msg);
    });
  }

  Stream<List<ChatMessage>> getMessagesByRoom(String roomId) {
    var str = MyDatabase().messageDao.getMessagesByRoomId(roomId).asyncMap(
        (dbMessages) =>
            dbMessages.map((dm) => ChatMessage.fromMap(dm.toJson())).toList());
    return str;
  }

  Stream<List<ContactChat>> getContacts() {
    var stream = MyDatabase().contactDao.getAllContacts().asyncMap(
        (dbContacts) =>
            dbContacts.map((dc) => ContactChat.fromMap(dc.toJson())).toList());
    return stream;
  }
}
