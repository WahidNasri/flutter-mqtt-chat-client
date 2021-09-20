import 'package:moor/moor.dart';

@DataClassName("DbInvitation")
class Invitations extends Table {
  TextColumn get id => text().named("id")();
  TextColumn get fromId => text().named("from_id")();
  TextColumn get fromName => text().named("from_name").nullable()();
  TextColumn get fromAvatar => text().named("from_avatar").nullable()();
  IntColumn get sendTime => integer().named("send_time")();
  @override
  Set<Column> get primaryKey => {id};
}
