import 'package:moor/moor.dart';

@DataClassName("DbMessage")
class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get fromId => text().named("from_id")();
  TextColumn get fromName => text().named("from_name").nullable()();
  TextColumn get toId => text().named("to_id").nullable()();
  TextColumn get toName => text().named("to_name").nullable()();
  TextColumn get textClm => text().named("text")();
  TextColumn get roomId => text().named("room_id")();
  TextColumn get originality => text()();
  TextColumn get attachment => text().nullable()();
  TextColumn get thumbnail => text().nullable()();
  TextColumn get originalId => text().named("original_id").nullable()();
  IntColumn get sendTime => integer().named("send_time")();
  IntColumn get size => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant("pending"))();
  TextColumn get mime => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
