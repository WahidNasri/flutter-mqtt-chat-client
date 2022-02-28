import 'package:example/database/models/room.dart';
import 'package:floor/floor.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';

@dao
abstract class RoomDao {
  @Query('SELECT * FROM Room')
  Stream<List<Room>> findAllRoomsAsync();

  @Query('SELECT * FROM Room WHERE isGroup = 0')
  Stream<List<Room>> findPrivateRoomsAsync();

  @Query('SELECT * FROM Room WHERE isGroup = 1')
  Stream<List<Room>> findGroupRoomsAsync();

  @Query("UPDATE Room SET presence = :presence WHERE otherMemberId = :userId")
  Future<void> updateRoomPresence(String userId, PresenceType presence);

  @Query("DELETE FROM Room")
  Future<void> deleteAllRooms();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRooms(List<Room> rooms);
}
