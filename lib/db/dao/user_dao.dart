import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  final MyDatabase db;

  UserDao(this.db) : super(db);
  //============Users============//
  Future<int> addUser(DbUser user) {
    return into(users).insert(user);
  }

  Future<List<DbUser>> getUser() {
    return (select(users)..limit(1)).get();
  }

  Stream<List<DbUser>> getUserAsync() {
    return (select(users)..limit(1)).watch();
  }

  Future<void> setClientId(String clientId) async {
    var us = await getUser();
    if (us.length > 0) {
      var u = us[0];
      var nu = u.copyWith(client_id: clientId);

      update(users).replace(nu);
    }
  }

  Future deleteAllUsers() {
    return (delete(users)).go();
  }
}
