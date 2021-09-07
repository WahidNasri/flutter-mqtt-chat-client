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
    return (select(messages)
            ..where((tbl) => tbl.roomId.equals(roomId))
            ..orderBy([(t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)]))
        .watch();
  }
  Stream<List<DbMessage>> getAllMessages() {
    return (select(messages)..orderBy([(t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)])).watch();

  }

  Future<int> addMessage(DbMessage msg) {
    return into(messages).insertOnConflictUpdate(msg);
  }
  Future<DbMessage?> getMessageById(String id){
    return (select(messages)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
  Future<void> setMessageDelivered(String id) async {
    DbMessage? msg = await getMessageById(id);
    if(msg != null && msg.status != "displayed"){
      var other = msg.copyWith(status: "delivered");
       (update(messages)..where((t) => t.id.equals(id))).write(other);
    }
  }
  Future<void> setMessageDisplayed(String id) async {
    DbMessage? msg = await getMessageById(id);
    if(msg != null){
      var other = msg.copyWith(status: "displayed");
      (update(messages)..where((t) => t.id.equals(id))).write(other);
    }
  }

  Future deleteAllMessages() {
    return (delete(messages)).go();
  }
}
