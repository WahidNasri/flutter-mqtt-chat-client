import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  final MyDatabase db;

  UserDao(this.db) : super(db);
  //============Users============//
  Future<int> addUser(DbUser user) async {
    var oldUser = await getUser();
    if (oldUser != null) {
      var nuser =
          user.copyWith(username: oldUser.username, password: oldUser.password);
      return into(users).insertOnConflictUpdate(nuser);
    }
    return into(users).insertOnConflictUpdate(user);
  }

  Future<DbUser?> getUser() {
    return (select(users)..limit(1)).getSingleOrNull();
  }

  Stream<List<DbUser>> getUserAsync() {
    return (select(users)..limit(1)).watch();
  }

  Future<void> setClientId(String clientId) async {
    var us = await getUser();
    if (us == null) {
      var nu = us!.copyWith(client_id: clientId);

      update(users).replace(nu);
    }
  }

  Future deleteAllUsers() {
    return (delete(users)).go();
  }
}
