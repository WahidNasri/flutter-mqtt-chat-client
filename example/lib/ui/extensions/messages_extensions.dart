import 'package:example/database/models/message.dart';
import 'package:example/database/models/user.dart';
import 'package:flutter_chat_mqtt/models/enums.dart';
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
          createdAt: sendTime.millisecondsSinceEpoch,
          status: status.toStatus());
    } else if (type == MessageType.chatImage) {
      return types.ImageMessage(
          id: id,
          uri: attachment ?? '',
          size: size ?? 0,
          name: text,
          author: author,
          createdAt: sendTime.millisecondsSinceEpoch,
          status: status.toStatus());
    }

    return types.UnsupportedMessage(
        id: id,
        author: author,
        createdAt: sendTime.millisecondsSinceEpoch,
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
}
