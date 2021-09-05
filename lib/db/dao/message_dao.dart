import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/MessageTable.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'message_dao.g.dart';

@UseDao(tables: [Messages])
class MessageDao extends DatabaseAccessor<MyDatabase> with _$MessageDaoMixin {
  final MyDatabase db;

  MessageDao(this.db) : super(db);
  //============MESSAGES============//
  Stream<List<DbMessage>> getMessagesByRoomId(String roomId) {
    return (select(messages)..where((tbl) => tbl.roomId.equals(roomId)))
        .watch();
  }

  Future<int> addMessage(DbMessage msg) {
    return into(messages).insert(msg);
  }

  Future deleteAllMessages() {
    return (delete(messages)).go();
  }
}
