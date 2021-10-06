import 'package:moor/moor.dart';

@DataClassName("DbContact")
class Contacts extends Table {
  TextColumn get id => text().named("id")();
  TextColumn get lastName => text().named("last_name")();
  TextColumn get firstName => text().named("first_name")();
  TextColumn get roomId => text().named("room_id")();
  //TextColumn get isGroup => text()();
  TextColumn get avatar => text().nullable()();
  BoolColumn get isGroup => boolean().named("is_group")();
  TextColumn get presence => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
