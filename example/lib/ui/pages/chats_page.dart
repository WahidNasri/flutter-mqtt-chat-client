import 'package:example/database/models/room.dart';
import 'package:example/proviers/chat_providers.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:example/ui/extensions/messages_extensions.dart';
import 'package:example/ui/screens/chat_room_screen.dart';
import 'package:example/ui/widgets/room_avatar.dart';
import 'package:example/ui/widgets/typing_indicator_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentChatsPage extends ConsumerStatefulWidget {
  const RecentChatsPage({Key? key}) : super(key: key);

  @override
  _RecentChatsPageState createState() => _RecentChatsPageState();
}

class _RecentChatsPageState extends ConsumerState<RecentChatsPage> {
  @override
  Widget build(BuildContext context) {
    final stream = ref.watch(recentChatsProvider);
    final user = ref.watch(userProvider);

    return stream.when(
        data: (chats) => ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatRoomScreen(
                              room: Room(
                                  id: chats[index].roomId,
                                  name: chats[index].name,
                                  isGroup: chats[index].isGroup,
                                  avatar: chats[index].avatar))),
                    );
                  },
                  child: ListTile(
                    title: Text(chats[index].name),
                    subtitle: TypingIndicatorText(
                      fallbackWidget: Row(
                        children: [
                          chats[index].lastMessageStatus.toChatMarkerWidget(chats[index].lastMessageFromId == user.user!.id),
                          chats[index].lastMessageType.toIcon(),
                          const SizedBox(width: 5),
                          Expanded(child: Text(chats[index].lastMessageText, maxLines: 1)),
                        ],
                      ),
                      isGroup: chats[index].isGroup,
                      currentUserId: user.user != null ? user.user!.id : '',
                      roomId: chats[index].roomId,
                    ),
                    leading: SizedBox(
                        width: 50,
                        child: RoomAvatar.fromRecentChat(
                            recentChat: chats[index])),
                  ),
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: chats.length),
        error: (e, s) => Text(e.toString()),
        loading: () => Text("Loading..."));
  }
}
