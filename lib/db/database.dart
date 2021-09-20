import 'package:flutter_mqtt/db/dao/contact_dao.dart';
import 'package:flutter_mqtt/db/dao/invitation_dao.dart';
import 'package:flutter_mqtt/db/dao/message_dao.dart';
import 'package:flutter_mqtt/db/dao/user_dao.dart';
import 'package:flutter_mqtt/db/tables/ContactTable.dart';
import 'package:flutter_mqtt/db/tables/InvitationTable.dart';
import 'package:flutter_mqtt/db/tables/MessageTable.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';
part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chat.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
    tables: [Contacts, Users, Messages, Invitations],
    daos: [UserDao, ContactDao, MessageDao, InvitationDao])
class MyDatabase extends _$MyDatabase {
  static MyDatabase? _instance;
  static MyDatabase? instance() {
    if (_instance == null) {
      _instance = MyDatabase._();
    }
    return _instance;
  }

// we tell the database where to store the data with this constructor
  MyDatabase._() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
