import 'package:example/database/models/user.dart';
import 'package:example/proviers/db_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db_provider.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider(ref.watch(databaseProvider));
});

class UserProvider extends ChangeNotifier {
  User? user;
  DataBaseProvider dataBaseProvider;

  UserProvider(this.dataBaseProvider) {
    init();
  }

  void init() async {
    if(dataBaseProvider.database ==null){
      return;
    }
    dataBaseProvider.database!.userDao.findAllUsersAsync().listen((users) {
      user = users.isNotEmpty ? users.first : null;
      notifyListeners();
    });
  }
}
