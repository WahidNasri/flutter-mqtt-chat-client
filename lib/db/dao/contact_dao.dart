import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ContactTable.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'contact_dao.g.dart';

@UseDao(tables: [Contacts])
class ContactDao extends DatabaseAccessor<MyDatabase> with _$ContactDaoMixin {
  final MyDatabase db;

  ContactDao(this.db) : super(db);
  //==========Contacts==========//
  Future<int> addContact(DbContact cts) {
    return into(contacts).insertOnConflictUpdate(cts);
  }
  Stream<List<DbContact>> getAllContactsAndGroupsAsync() {
    return (select(contacts)).watch();
  }
  Stream<List<DbContact>> getAllContactsAsync() {
    return (select(contacts)..where((tbl) => tbl.isGroup.not())).watch();
  }
  Stream<List<DbContact>> getAllGroupsAsync() {
    return (select(contacts)..where((tbl) => tbl.isGroup)).watch();
  }

  Future<List<DbContact>> getAllContacts() {
    return (select(contacts)..where((tbl) => tbl.isGroup.not())).get();
  }
  Future<List<DbContact>> getAllGroups() {
    return (select(contacts)..where((tbl) => tbl.isGroup)).get();
  }
  Future<void> updateContactPresence(String contactId, PresenceType presence){
    return (update(contacts)..where((t) => t.id.equals(contactId))).write(
      ContactsCompanion(
        presence: Value(presence.toString().split(".")[1])
      ),
    );
  }

  Future<void> deleteAllContacts() {
    return delete(contacts).go();
  }
}
