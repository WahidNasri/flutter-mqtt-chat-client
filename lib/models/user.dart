import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
//@CopyWith()
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
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromString(String jsonString) => _$UserFromJson(json.decode(jsonString));

}
