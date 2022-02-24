import 'package:flutter_chat_mqtt/models/room_membership_message.dart';
import 'package:flutter_chat_mqtt/models/user.dart';

abstract class ArchiveHandler {
  Stream<User> getUser();
  Stream<List<RoomMembershipMessage>> getAllConversations();
  Future<void> dispose();
}
