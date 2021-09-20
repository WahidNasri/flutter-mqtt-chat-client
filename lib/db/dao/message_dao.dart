import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ContactTable.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
import 'package:flutter_mqtt/db/tables/MessageTable.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'message_dao.g.dart';

@UseDao(tables: [Messages, Contacts])
class MessageDao extends DatabaseAccessor<MyDatabase> with _$MessageDaoMixin {
  final MyDatabase db;

  MessageDao(this.db) : super(db);
  //============MESSAGES============//
  Stream<List<DbMessage>> getMessagesByRoomId(String roomId) {
    return (select(messages)
          ..where((tbl) => tbl.roomId.equals(roomId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<DbMessage>> getUnseenMessagesByRoomId(String roomId) {
    return (select(messages)
          ..where((tbl) =>
              tbl.roomId.equals(roomId) & tbl.status.isNotIn(["displayed"]))
          ..orderBy([
            (t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<DbMessage>> getMediaMessagesByRoomId(String roomId) {
    var mediaTypes = ["ChatImage", "ChatVideo"];
    return (select(messages)
          ..where(
              (tbl) => tbl.roomId.equals(roomId) & tbl.type.isIn(mediaTypes))
          ..orderBy([
            (t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Stream<List<DbMessage>> getAllMessages() {
    return (select(messages)
          ..orderBy([
            (t) => OrderingTerm(expression: t.sendTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<int> addMessage(DbMessage msg) {
    return into(messages).insertOnConflictUpdate(msg);
  }

  Future<DbMessage?> getMessageById(String id) {
    return (select(messages)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> setMessageDelivered(String id) async {
    DbMessage? msg = await getMessageById(id);
    if (msg != null && msg.status != "displayed") {
      var other = msg.copyWith(status: "delivered");
      (update(messages)..where((t) => t.id.equals(id))).write(other);
    }
  }

  Future<void> setMessageDisplayed(String id) async {
    DbMessage? msg = await getMessageById(id);
    if (msg != null) {
      var other = msg.copyWith(status: "displayed");
      (update(messages)..where((t) => t.id.equals(id))).write(other);
    }
  }

  Future deleteAllMessages() {
    return (delete(messages)).go();
  }

  // then, in the database class:
  Stream<List<ExtendedDbContact>> getConversations() {
    return customSelect(
      'SELECT c.id, c.first_name, c.last_name, c.avatar, c.room_id, m.mtype as message_type, m.mid as message_id, m.text as message_text, m.moriginality as message_originality, m.send_time '
      'FROM (select id as mid, type as mtype, from_id as mfrom_id, originality as moriginality, room_id as mroom_id, text, send_time from messages order by send_time desc) m JOIN contacts c on c.room_id = m.mroom_id '
      'GROUP BY room_id ORDER BY send_time DESC',
      readsFrom: {
        messages,
        contacts
      }, // used for the stream: the stream will update when either table changes
    ).watch().map((rows) {
      return rows.map((row) => ExtendedDbContact.fromJson(row.data)).toList();
    });
  }
}
