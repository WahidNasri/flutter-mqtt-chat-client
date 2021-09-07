import 'package:moor/moor.dart';

@DataClassName("DbUser")
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get lastName => text().named("last_name")();
  TextColumn get firstName => text().named("first_name")();
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get avatar => text().nullable()();
  TextColumn get client_id => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
