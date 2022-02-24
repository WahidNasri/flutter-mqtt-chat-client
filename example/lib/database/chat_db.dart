import 'dart:async';
import 'package:example/database/dao/message_dao.dart';
import 'package:example/database/dao/room_dao.dart';
import 'package:example/database/dao/user_dao.dart';
import 'package:example/database/models/message.dart';
import 'package:example/database/models/recent_chat.dart';
import 'package:example/database/models/room.dart';
import 'package:example/database/models/user.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'chat_db.g.dart';

@TypeConverters([DateTimeConverter, MessageTypeConverter, MessageOriginalityConverter, ChatMarkerConverter, PresenceTypeConverter])
@Database(version: 1, entities: [User, Room, Message], views: [RecentChat])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  RoomDao get roomDao;
  MessageDao get messageDao;

  static AppDatabase? _database;

  static Future<AppDatabase?> instance() async {
    _database ??= await $FloorAppDatabase.databaseBuilder('chat_db.db').build();
    return _database;
  }

  deleteAll(){
    userDao.deleteAllUsers();
    roomDao.deleteAllRooms();
    messageDao.deleteAllMessages();
  }
}
