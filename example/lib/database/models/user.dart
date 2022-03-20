import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  final String id;
  final String name;
  final String clientId;
  final String username;
  final String password;
  final String? avatar;

  User(
      {required this.id,
      required this.name,
      required this.clientId,
      required this.username,
      required this.password,
      this.avatar});
}
