import 'package:flutter_mqtt/abstraction/models/enums/ChatMarker.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';
import 'package:flutter_mqtt/db/appdata/ContactsHandler.dart';
import 'package:flutter_mqtt/db/appdata/MessageHandler.dart';
import 'package:flutter_mqtt/db/appdata/UsersHandler.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
import 'package:flutter_mqtt/db/appdata/extensions/MessagesExtensions.dart';

class AppData {
  static AppData? _instance;
  static AppData? instance() {
    if (_instance == null) {
      _instance = new AppData();
    }
    return _instance;
  }

  late MessagesHandler messagesHandler;
  late ContactsHandler contactsHandler;
  late UsersHandler usersHandler;

  AppData() {
    messagesHandler = MessagesHandler();
    contactsHandler = ContactsHandler();
    usersHandler = UsersHandler();
    //================ROOMS================//
    ChatApp.instance()!.archiveHandler.getAllConversations().listen((rooms) {
      var list = rooms.map((e) {
        return e.toDbContact();
      }).toList();
      for (var ctc in list) {
        MyDatabase.instance()!.contactDao.addContact(ctc);
      }
    });

    //================User================//
    ChatApp.instance()!.archiveHandler.getUser().listen((user) {
      usersHandler.insertUserFromPayload(
          user, ChatApp.instance()!.clientHandler.getClientId()!);
    });

    //===============Messages============//
    ChatApp.instance()!.messageReader.getChatMessages().listen((message) {
      var dbMessage = message.toDbMessage();
      MyDatabase.instance()!.messageDao.addMessage(dbMessage);
      //SEND CHAT MARKER
      ChatApp.instance()!
          .eventsSender
          .sendChatMarker(message.id, ChatMarker.delivered, message.roomId);
    });
    //============Chat Marker==========//
    ChatApp.instance()!
        .messageReader
        .getChatMarkerMessages()
        .listen((markerMessage) {
      if (markerMessage.status == ChatMarker.displayed) {
        MyDatabase.instance()!
            .messageDao
            .setMessageDisplayed(markerMessage.referenceId);
      } else if (markerMessage.status == ChatMarker.delivered) {
        MyDatabase.instance()!
            .messageDao
            .setMessageDelivered(markerMessage.referenceId);
      }
    });

    //========== Invitations =========//
    ChatApp.instance()!
        .invitationHandler
        .newInvitationsStream()
        .listen((invitation) {
      MyDatabase.instance()!
          .invitationDao
          .addInvitation(invitation.toDbInvitation());
    });

    ChatApp.instance()!
        .invitationHandler
        .invitationUpdatesStream()
        .listen((invitation) {
      if (invitation.invitationMessageType == InvitationMessageType.INFO) {}
    });
  }

  Future deleteAllAndDisconnect() async {
    for (var contact in await contactsHandler.getContactsList()) {
      ChatApp.instance()!.clientHandler.leaveRoom(contact.roomId);
      ChatApp.instance()!.clientHandler.leaveContactEvents(contact.id);
    }
    ChatApp.instance()!.disconnect();
    await deleteAll();
  }

  Future deleteAll() async {
    await usersHandler.deleteAll();
    await messagesHandler.deleteAll();
    await contactsHandler.deleteAll();
  }
}
