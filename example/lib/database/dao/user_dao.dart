import 'package:example/database/models/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao{
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM User')
  Stream<List<User>> findAllUsersAsync();

  @Query("DELETE FROM User")
  Future<void> deleteAllUsers();

  @transaction
  Future<void> insertUser(User user) async{
    await deleteAllUsers();
    insertUserInternal(user);
  }
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUserInternal(User user);
}