import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String id;
  String? avatar;
  User({
    required this.firstName,
    required this.lastName,
    required this.id,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      id: map['id'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
