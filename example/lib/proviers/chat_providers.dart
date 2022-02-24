import 'package:example/database/models/message.dart';
import 'package:example/database/models/recent_chat.dart';
import 'package:example/database/models/room.dart';
import 'package:example/proviers/db_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentChatsProvider = StreamProvider<List<RecentChat>>((ref){
  final db = ref.watch(databaseProvider);
  if (db.database != null) {
    return db.database!.messageDao.getRecentChats();
  } else {
    return const Stream.empty();
  }
});

final roomsProvider = StreamProvider<List<Room>>((ref) {
  final db = ref.watch(databaseProvider);
  if (db.database != null) {
    return db.database!.roomDao.findAllRoomsAsync();
  } else {
    return const Stream.empty();
  }
});

final messagesProvider =
    StreamProvider.autoDispose.family<List<Message>, String>((ref, roomId) {
  final db = ref.watch(databaseProvider);
  if (db.database != null) {
    return db.database!.messageDao.allMessagesByRoomId(roomId);
  } else {
    return const Stream.empty();
  }
});
