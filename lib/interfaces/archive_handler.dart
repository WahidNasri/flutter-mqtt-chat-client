import 'package:flutter_mqchat/models/room_membership_message.dart';
import 'package:flutter_mqchat/models/user.dart';

abstract class ArchiveHandler {
  Stream<User> getUser();
  Stream<List<RoomMembershipMessage>> getAllConversations();
  Future<void> dispose();
}
