import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/db/database.dart';

class UsersHandler {
  String? _waitingUsername, _waitingPassword;
  void storeWaitingCredentials(String username, String password) {
    _waitingUsername = username;
    _waitingPassword = password;
  }

  void insertUserFromPayload(User user, String clientId) {
    var map = user.toMap();
    DbUser dbUser = DbUser.fromJson(user.toMap()).copyWith(
        client_id: clientId,
        username: _waitingUsername,
        password: _waitingPassword);

    MyDatabase.instance()!
        .userDao
        .deleteAllUsers()
        .then((value) => MyDatabase.instance()!.userDao.addUser(dbUser));
  }

  Future<DbUser?> getLocalUser() {
    return MyDatabase.instance()!.userDao.getUser();
  }

  Future deleteAll() {
    return MyDatabase.instance()!.userDao.deleteAllUsers();
  }
}
