import 'dart:convert';

class ContactChat {
  String firstName;
  String lastName;
  String id;
  String? avatar;
  String roomId;
  bool? isGroup;
  ContactChat(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.avatar,
      required this.roomId,
      required this.isGroup});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName':lastName,
      'id': id,
      'avatar': avatar,
      'roomId': roomId,
      'isGroup': isGroup,
    };
  }

  factory ContactChat.fromMap(Map<String, dynamic> map) {
    return ContactChat(
      firstName: map['firstName'],
      lastName: map['lastName'],
      id: map['id'],
      avatar: map['avatar'],
      roomId: map['roomId'],
      isGroup: map['isGroup'] != null && map['isGroup'] == 'true',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactChat.fromJson(String source) =>
      ContactChat.fromMap(json.decode(source));
}
