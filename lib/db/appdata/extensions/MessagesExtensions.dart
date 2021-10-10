import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/InvitationMessage.dart';
import 'package:flutter_mqtt/db/database.dart';

extension DbMessageConversions on DbMessage {
  ChatMessage toChatMessage() {
    var map = toJson();
    map.putIfAbsent("text", () => map["textClm"]);
    var cm = ChatMessage.fromJson(map);
    return cm;
  }
}

extension ChatMessageConversions on ChatMessage {
  DbMessage toDbMessage({String? status}) {
    var map = toJson();
    map.putIfAbsent("textClm", () => map["text"]);
    map["status"] = status ?? "delivered";
    DbMessage msg = DbMessage.fromJson(map);
    return msg;
  }
}

extension DbContactConversions on DbContact {
  ContactChat toContactChat() {
    return ContactChat.fromJson(toJson());
  }
}

extension ContactChatConversions on ContactChat {
  DbContact toDbContact() {
    var map = toJson();
    DbContact dbc = DbContact.fromJson(map);
    return dbc;
  }
}

extension InvitationConversions on InvitationMessage {
  DbInvitation toDbInvitation() {
    return DbInvitation(
        id: id,
        fromId: fromId!,
        fromName: fromName,
        fromAvatar: fromAvatar,
        sendTime: sendTime,
        incoming: true,
        status: "confirmed");
  }
}
