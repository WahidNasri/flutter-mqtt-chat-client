import 'package:example/database/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

extension MessagesExtension on Message {
  types.Message toUiMessage(
      {required String userId, required String name, String? avatar}) {
    types.User author =
        types.User(id: userId, firstName: name, imageUrl: avatar);
    if (type == MessageType.chatText) {
      return types.TextMessage(
          roomId: roomId,
          id: id,
          text: text,
          author: author,
          metadata: toJson(),
          createdAt: sendTime.millisecondsSinceEpoch,
          status: status.toStatus());
    } else if (type == MessageType.chatImage) {
      return types.ImageMessage(
          id: id,
          uri: attachment ?? '',
          size: size ?? 0,
          name: text,
          author: author,
          metadata: toJson(),
          createdAt: sendTime.millisecondsSinceEpoch,
          status: status.toStatus());
    } else if (type == MessageType.chatVideo) {
      //TODO: implement UI with video thumb

      return types.FileMessage(
          //return types.ImageMessage(
          author: author,
          createdAt: sendTime.microsecondsSinceEpoch,
          id: id,
          size: size ?? 0,
          name: text,
          mimeType: mime,
          metadata: toJson(),
          uri: attachment ?? '',
          status: status.toStatus());
    } else if (type == MessageType.chatDocument) {
      return types.FileMessage(
          author: author,
          createdAt: sendTime.microsecondsSinceEpoch,
          id: id,
          mimeType: mime,
          size: size ?? 0,
          name: text,
          metadata: toJson(),
          uri: attachment ?? '',
          status: status.toStatus());
    } else if (type == MessageType.chatLocation) {
      return types.ImageMessage(
          id: id,
          uri:
              "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&markers=color:blue%7C$latitude,$longitude&zoom=13&size=300x200&maptype=roadmap&key=AIzaSyDs9qcIhAV-aToQiGOIRlVTzFtrbh1z7tU",
          size: size ?? 0,
          name: text,
          author: author,
          metadata: toJson(),
          createdAt: sendTime.millisecondsSinceEpoch,
          status: status.toStatus());
    }

    return types.UnsupportedMessage(
        id: id,
        author: author,
        createdAt: sendTime.millisecondsSinceEpoch,
        metadata: toJson(),
        status: status.toStatus());
  }
}

extension ChatMarkerUIExtension on ChatMarker? {
  types.Status toStatus() {
    switch (this) {
      case ChatMarker.sent:
        return types.Status.sent;
      case ChatMarker.delivered:
        return types.Status.delivered;
      case ChatMarker.displayed:
        return types.Status.seen;
      default:
        types.Status.sending;
    }
    return types.Status.sending;
  }

  Widget toChatMarkerWidget(bool isMine) {
    if (this == null || !isMine) {
      return const SizedBox();
    }

    return Icon(
      this == ChatMarker.sent
          ? Icons.done
          : this == ChatMarker.delivered || this == ChatMarker.displayed
              ? Icons.done_all
              : Icons.timer,
      color: this == ChatMarker.displayed ? Colors.green : Colors.grey,
      size: 20,
    );
  }
}

extension MessageTypeUiExtensions on MessageType {
  Widget toIcon({double size = 15}) {
    switch (this) {
      case MessageType.chatImage:
        return Icon(Icons.image, size: size);
      case MessageType.chatVideo:
        return Icon(Icons.video_library, size: size);
      case MessageType.chatAudio:
        return Icon(Icons.audiotrack_sharp, size: size);
      case MessageType.chatDocument:
        return Icon(Icons.menu_book, size: size);
      case MessageType.chatLocation:
        return Icon(Icons.location_pin, size: size);
      case MessageType.chatContact:
        return Icon(Icons.contact_page_sharp, size: size);
      default:
        return const SizedBox();
    }
  }
}
