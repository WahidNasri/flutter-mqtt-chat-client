import 'package:flutter_mqtt/abstraction/models/enums/ChatMarker.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:flutter_mqtt/abstraction/models/enums/PresenceType.dart';
import 'package:flutter_mqtt/db/appdata/ContactsHandler.dart';
import 'package:flutter_mqtt/db/appdata/InvitationsHandler.dart';
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
  DbUser? user;

  late MessagesHandler messagesHandler;
  late ContactsHandler contactsHandler;
  late UsersHandler usersHandler;
  late InvitationsHandler invitationsHandler;

  AppData() {
    messagesHandler = MessagesHandler();
    contactsHandler = ContactsHandler();
    usersHandler = UsersHandler();
    invitationsHandler = InvitationsHandler();

    usersHandler.getLocalUserAsync().listen((event) {
      user = event;
    });
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
      bool mine = user != null && message.fromId == user!.id;
      if(!mine) {
        ChatApp.instance()!
            .eventsSender
            .sendChatMarker(message.id, ChatMarker.delivered, message.roomId);
      }
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
          if(invitation.type == MessageType.EventInvitationRequest) {
            //new invitation request
            MyDatabase.instance()!
                .invitationDao
                .addInvitation(invitation.toDbInvitation());
          }
          if(invitation.type == MessageType.EventInvitationResponseAccept || invitation.type == MessageType.EventInvitationResponseReject) {
            //responded to invitation, update the local record and wait the server to sync the new contact (if accepted)
            invitationsHandler.updateInvitationStatus(invitation.id, invitation.type == MessageType.EventInvitationResponseAccept ? "accepted" : "rejected");
          }
    });

    ChatApp.instance()!
        .invitationHandler
        .invitationUpdatesStream()
        .listen((invitation) {
      if (invitation.invitationMessageType == InvitationMessageType.INFO) {
        invitationsHandler.updateInvitationStatus(invitation.id, "confirmed");
      }
      else if (invitation.invitationMessageType == InvitationMessageType.ERROR) {
        invitationsHandler.deleteInvitation(invitation.id);
      }
    });
  }

  Future deleteAllAndDisconnect() async {
    for (var contact in await contactsHandler.getContactsList()) {
      ChatApp.instance()!.clientHandler.leaveRoom(contact.roomId);
      ChatApp.instance()!.clientHandler.leaveContactEvents(contact.id);
    }
    if(user != null) {
      ChatApp.instance()!.eventsSender.sendPresence(
          PresenceType.Unavailable, user!.id);
    }
    ChatApp.instance()!.disconnect();
    await deleteAll();
  }

  Future deleteAll() async {
    await usersHandler.deleteAll();
    await messagesHandler.deleteAll();
    await contactsHandler.deleteAll();
    invitationsHandler.deleteAll();
  }
}
