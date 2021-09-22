import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqtt/abstraction/models/ChatMessage.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/abstraction/models/enums/MessageType.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ExtendedDbContact.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

extension MessageConversions on ChatMessage {
  types.Message toUiMessage() {
    var author = types.User(id: fromId ?? "", firstName: fromName);
    switch (type) {
      case MessageType.ChatText:
        return types.TextMessage(
            id: id, text: text, createdAt: sendTime, author: author);
      case MessageType.ChatImage:
        return types.ImageMessage(
            author: author,
            id: id,
            name: "Image",
            uri: attachment!,
            size: size ?? 0);
      case MessageType.ChatVideo:
      case MessageType.ChatAudio:
      case MessageType.ChatDocument:
        return types.FileMessage(
            author: author,
            id: id,
            name: text,
            uri: attachment!,
            mimeType: mime,
            size: size ?? 0);
      default:
        return types.UnsupportedMessage(id: id, author: author);
    }
  }

  Widget toGridItem() {
    if (type == MessageType.ChatImage) {
      return CachedNetworkImage(
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        imageUrl: attachment ?? "",
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return SizedBox();
  }

  Widget toPagerItem(){
    if (type == MessageType.ChatImage) {
      return CachedNetworkImage(
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        imageUrl: attachment ?? "",
        fit: BoxFit.contain,
        width: double.infinity,
      );
    }
    //TODO: handle video, audio
    return SizedBox();
  }

  String formatDate(String format){
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(sendTime));
  }
}

extension DbMessageConversions on DbMessage {
  types.Message toUiMessage() {
    var author = types.User(id: fromId, firstName: fromName);
    switch (type) {
      case "ChatText":
        return types.TextMessage(
            id: id,
            text: textClm,
            createdAt: sendTime,
            author: author,
            status: getStatus(status));
      case "ChatImage":
        return types.ImageMessage(
            author: author,
            id: id,
            name: "Image",
            uri: attachment!,
            size: size);
      case "ChatVideo":
      case "ChatAudio":
      case "ChatDocument":
        return types.FileMessage(
            author: author,
            id: id,
            name: textClm,
            uri: attachment!,
            mimeType: mime,
            size: size,
            status: getStatus(status));
      default:
        return types.UnsupportedMessage(id: id, author: author);
    }
  }
}

extension UserConversions on User {
  types.User toUiUser() {
    return types.User(
        id: id, firstName: firstName, lastName: lastName, imageUrl: avatar);
  }
}

extension LocalUserConversions on DbUser {
  types.User toUiUser2() {
    return types.User(
        id: id, firstName: firstName, lastName: lastName, imageUrl: avatar);
  }
}

extension ExtendedExtensions on ExtendedDbContact {
  DbContact toDbContact() {
    return DbContact(
        id: id,
        lastName: last_name,
        firstName: first_name,
        roomId: room_id,
        avatar: avatar);
  }

  ContactChat toContactChat() {
    return ContactChat(
        firstName: first_name,
        lastName: last_name,
        id: id,
        avatar: avatar,
        roomId: room_id,
        isGroup: false);
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

types.Status getStatus(String status) {
  if (status.toLowerCase() == "delivered") {
    return types.Status.delivered;
  } else if (status.toLowerCase() == "sent") {
    return types.Status.sent;
  } else if (status.toLowerCase() == "displayed" ||
      status.toLowerCase() == "seen") {
    return types.Status.seen;
  }
  return types.Status.error;
}
