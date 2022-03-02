import 'package:example/database/models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqchat/models/enums.dart';

extension RoomsExtensions on Room {
  Color get presenceColor {
    if (presence != null) {
      if (presence == PresenceType.available) {
        return Colors.green;
      } else if (presence == PresenceType.away) {
        return Colors.yellow;
      }
    }
    return Colors.grey;
  }
}
