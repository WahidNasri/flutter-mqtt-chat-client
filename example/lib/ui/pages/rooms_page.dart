import 'package:example/database/chat_db.dart';
import 'package:example/database/models/room.dart';
import 'package:example/proviers/chat_providers.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/screens/chat_room_screen.dart';
import 'package:example/ui/widgets/room_avatar.dart';
import 'package:example/ui/widgets/typing_indicator_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomsPage extends ConsumerStatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RoomsPage> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    final strem = ref.watch(roomsProvider);
    final user = ref.watch(userProvider);
    return strem.when(
        data: (rooms) => ListView.separated(
            itemCount: rooms.length,
            separatorBuilder: (c, i) => const Divider(),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatRoomScreen(room: rooms[index])),
                    );
                  },
                  child: ListTile(
                      leading: SizedBox(width: 50,child: RoomAvatar(room: rooms[index])),
                      title: Text(rooms[index].name),
                      subtitle: TypingIndicatorText(
                        roomId: rooms[index].id,
                        currentUserId: user.user != null ?  user.user!.id : "",
                        isGroup: rooms[index].isGroup,
                        fallbackWidget: Text("Room ID: "+ rooms[index].id),
                      )),
                )),
        error: (o, s) => Text(o.toString()),
        loading: () => Text("Loading..."));
  }
}
