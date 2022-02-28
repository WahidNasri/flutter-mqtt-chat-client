import 'package:example/database/chat_db.dart';
import 'package:example/database/models/message.dart';
import 'package:example/database/models/room.dart';
import 'package:example/database/models/user.dart';
import 'package:example/utils/preferences.dart';
import 'package:flutter_chat_mqtt/chat_app.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';

//TODO: Migrate to a provider
class AppData {
  User? user;
  AppData() {
    AppDatabase.instance().then((db){
      if(db != null){
        db.userDao.findAllUsersAsync().listen((users){
          if(users.isNotEmpty){
            user = users.first;
          }
        });
      }
    });
    //================User================//
    ChatApp.instance()!.archiveHandler.getUser().listen((user) {
      AppDatabase.instance().then((db) async {
        db!.userDao.insertUser(User(
            id: user.id,
            name: user.firstName,
            username: await AppPreferences.username() ?? "",
            password: await AppPreferences.password() ?? "",
            clientId: ChatApp.instance()?.clientHandler.getClientId() ?? "",
            avatar: user.avatar));
      });
    });

    //================ROOMS================//
    ChatApp.instance()!.archiveHandler.getAllConversations().listen((rooms) {
      AppDatabase.instance().then((db) async {
        final users = await db?.userDao.findAllUsers();
        final user = users != null && users.isNotEmpty
            ? users[0]
            : User(id: '0', name: '', clientId: '', username: '', password: '');

        final dbRooms = rooms
            .map((r) => Room(
                id: r.roomId,
                otherMemberId: r.isGroup
                    ? null
                    : r.members?.firstWhere((m) => m.id != user.id).id,
                name: r.firstName ?? 'ROOM',
                avatar: r.avatar,
                isGroup: r.isGroup))
            .toList();
        db!.roomDao.insertRooms(dbRooms);
      });
    });
    //==========Messages==========//
    ChatApp.instance()!.messageReader.getChatMessages().listen((message) {
      //INSERT TO DB
      AppDatabase.instance().then((db) {
        db!.messageDao.insertMessage(Message(
            id: message.id,
            type: message.type,
            fromId: message.fromId,
            fromName: message.fromName,
            toId: message.toId,
            toName: message.toName,
            text: message.text,
            roomId: message.roomId,
            originality: message.originality,
            attachment: message.attachment,
            thumbnail: message.thumbnail,
            originalId: message.originalId,
            originalMessage: message.originalMessage,
            size: message.size,
            mime: message.mime,
            longitude: message.longitude,
            latitude: message.latitude,
            status: message.fromId != user!.id ? ChatMarker.delivered : ChatMarker.sent, //default when received is Delivered
            sendTime: message.sendTime != null
                ? DateTime.fromMillisecondsSinceEpoch(message.sendTime ?? 0)
                : DateTime.now()));
      });
      //SEND CHAT MARKER
      bool mine = false; //FIXME: compare fromId with current user id
      if (!mine) {
        ChatApp.instance()!
            .eventsSender
            .sendChatMarker(message.id, ChatMarker.delivered, message.roomId);
      }
    });

    //====== Chat Marker ======//
    ChatApp.instance()!.messageReader.getChatMarkerMessages().listen((marker) {
      AppDatabase.instance().then((db) {
        if (db != null) {
          db.messageDao
              .updateMessageStatus(marker.status.name, marker.referenceId);
        }
      });
    });

    //======== Presence ==========//
    ChatApp.instance()!.messageReader.getPresenceMessages().listen((event) {
      AppDatabase.instance().then((db) {
        if (db != null) {
          db.roomDao.updateRoomPresence(event.fromId ?? "", event.presenceType);
        }
      });
    });
  }
}
