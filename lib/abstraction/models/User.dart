import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'User.g.dart';

@JsonSerializable()
@CopyWith()

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
  factory User.fromString(String jsonString) => _$UserFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
