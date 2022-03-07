import 'package:floor/floor.dart';
import 'package:flutter_mqchat/models/enums.dart';

@entity
class Room {
  @primaryKey
  final String id;
  final String? otherMemberId;
  final String name;
  final String? avatar;
  final bool isGroup;
  final PresenceType? presence;

  Room(
      {required this.id,
      this.otherMemberId, //only for non group rooms
      required this.name,
      this.avatar,
      required this.isGroup,
      this.presence});
}

class PresenceTypeConverter extends TypeConverter<PresenceType?, String?> {
  @override
  PresenceType? decode(String? databaseValue) {
    if (databaseValue != null) {
      return PresenceType.values.byName(databaseValue);
    }
    return null;
  }

  @override
  String? encode(PresenceType? value) {
    if (value != null) {
      return value.name;
    }
    return null;
  }
}

class PresenceNotNullTypeConverter extends TypeConverter<PresenceType, String> {
  @override
  PresenceType decode(String databaseValue) {
    return PresenceType.values.byName(databaseValue);
  }

  @override
  String encode(PresenceType value) {
    return value.name;
  }
}
