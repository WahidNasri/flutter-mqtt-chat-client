import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';

abstract class ArchiveHandler {
  Stream<User> getUser();
  Stream<List<ContactChat>> getAllConversations();
  Future<void> dispose();
}
