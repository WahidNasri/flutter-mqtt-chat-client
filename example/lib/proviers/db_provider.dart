import 'package:example/database/chat_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = ChangeNotifierProvider<DataBaseProvider>((ref) {
  return DataBaseProvider();
});

class DataBaseProvider extends ChangeNotifier {
  AppDatabase? database;

  DataBaseProvider() {
    // this will run when provider is instantiate the first time
    init();
  }

  void init() async {
    database = await AppDatabase.instance();
    notifyListeners();
  }
}
