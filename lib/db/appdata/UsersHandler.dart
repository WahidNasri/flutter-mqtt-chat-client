import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/db/database.dart';

class UsersHandler {
  String? _waitingUsername, _waitingPassword;
  void storeWaitingCredentials(String username, String password) {
    _waitingUsername = username;
    _waitingPassword = password;
  }

  void insertUserFromPayload(User user, String clientId) {
    DbUser dbUser = DbUser.fromJson(user.toJson()).copyWith(
        client_id: clientId,
        username: _waitingUsername,
        password: _waitingPassword);

    insertOrUpdateUser(dbUser);

  }

  Future<DbUser?> getLocalUser() {
    return MyDatabase.instance()!.userDao.getUser();
  }

  Stream<DbUser?> getLocalUserAsync(){
    return MyDatabase.instance()!.userDao.getUserAsync().map((users){
      if(users.length == 0){
        return null;
      }
      else{
        return users[0];
      }
    });
  }
  void insertOrUpdateUser(DbUser user){
    getLocalUser().then((oldUser) {
      if(oldUser != null){
        DbUser newRecord = user.copyWith(username: oldUser.username, password: oldUser.password);
        MyDatabase.instance()!.userDao.addUser(newRecord);
      }
      else{
        MyDatabase.instance()!.userDao.addUser(user);
      }
    });
  }
  Future deleteAll() {
    return MyDatabase.instance()!.userDao.deleteAllUsers();
  }
}
