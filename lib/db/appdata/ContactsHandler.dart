import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/appdata/extensions/MessagesExtensions.dart';

class ContactsHandler {
  Stream<List<ContactChat>> getContacts() {
    var stream = MyDatabase.instance()!.contactDao.getAllContactsAsync().map(
        (dbContacts) => dbContacts.map((dc) => dc.toContactChat()).toList());
    return stream;
  }

  Future<List<ContactChat>> getContactsList() async {
    return (await MyDatabase.instance()!.contactDao.getAllContacts())
        .map((dbContact) => dbContact.toContactChat())
        .toList();
  }

  Future deleteAll() {
    return MyDatabase.instance()!.contactDao.deleteAllContacts();
  }
}
