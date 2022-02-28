import 'package:example/database/models/room.dart';
import 'package:example/ui/widgets/room_avatar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Room room;
  const ProfileScreen({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Hero(
                tag: "avatar_" + room.id,
                child: RoomAvatar(
                  room: room,
                  radius: 50,
                )),
            const SizedBox(height: 10),
            Text(
              room.name,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
