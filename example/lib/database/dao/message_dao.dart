import 'package:example/database/models/message.dart';
import 'package:example/database/models/recent_chat.dart';
import 'package:floor/floor.dart';

@dao
abstract class MessageDao{
  @Query('SELECT * FROM Message')
  Stream<List<Message>> allMessages();

  @Query('SELECT * from recentChat')
  Stream<List<RecentChat>> getRecentChats();

  @Query('SELECT * FROM Message WHERE roomId = :roomId')
  Stream<List<Message>> allMessagesByRoomId(String roomId);
  
  @Query("SELECT * FROM Message WHERE status is null")
  Future<List<Message>> getUnsentMessages();

  @Query("UPDATE Message SET status = :chatMarker WHERE id = :messageId")
  Future<void> updateMessageStatus(String chatMarker, String messageId);

  @Query("DELETE FROM Message")
  Future<void> deleteAllMessages();

  @Query("DELETE FROM Message WHERE roomId = :roomId")
  Future<void> deleteAllMessagesByRoomId(String roomId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMessages(List<Message> messages);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMessage(Message message);

}