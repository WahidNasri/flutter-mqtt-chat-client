import 'dart:convert';

import 'package:flutter_mqchat/extensions/topics_extensions.dart';
import 'package:flutter_mqchat/interfaces/chat_events_sender.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/models/chat_marker_message.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_mqchat/models/invitation_message.dart';
import 'package:flutter_mqchat/models/presence_message.dart';
import 'package:flutter_mqchat/models/typing_indicator_message.dart';
import 'package:uuid/uuid.dart';

class MqttChatEventsSender extends ChatEventsSender {
  final ClientHandler clientHandler;

  MqttChatEventsSender({required this.clientHandler});
  @override
  void sendChatMarker(String messageId, ChatMarker marker, String bareRoom) {
    String topic = bareRoom.toRoomEventsTopic;

    ChatMarkerMessage msg = ChatMarkerMessage(
        id: const Uuid().v4(),
        type: MessageType.chatMarker,
        referenceId: messageId,
        status: marker);
    clientHandler.sendPayload(msg.toJson().toString(), topic);
  }

  @override
  void sendIsTyping(bool isTyping, String bareRoom) {
    TypingIndicatorMessage message = TypingIndicatorMessage(
        id: const Uuid().v4(),
        type: MessageType.typing,
        isTyping: isTyping,
        roomId: bareRoom);

    String topic = bareRoom.toRoomEventsTopic;
    clientHandler.sendPayload(message.toJson().toString(), topic);
  }

  @override
  void respondToInvitation(String invitationId, String senderId, bool accept) {
    InvitationMessage invitationMessage = InvitationMessage(
        id: invitationId,
        type: accept
            ? MessageType.invitationResponseAccept
            : MessageType.invitationResponseReject,
        sendTime: DateTime.now().millisecondsSinceEpoch);

    clientHandler.sendPayload(
        invitationMessage.toJson().toString(), senderId.toPersonalEventTopic);
  }

  @override
  void sendInvitation(String username, String? invitationId) {
    InvitationMessage message = InvitationMessage(
        id: invitationId ?? const Uuid().v4(),
        type: MessageType.invitationRequest,
        sendTime: DateTime.now().millisecondsSinceEpoch);

    String topic =
        username.toInvitationEventTopic; //TODO: decide the right topic
    clientHandler.sendPayload(message.toJson().toString(), topic);
  }

  @override
  void sendPresence(PresenceType presenceType, String myId) {
    PresenceMessage presenceMessage = PresenceMessage(
        id: const Uuid().v4(),
        type: MessageType.presence,
        presenceType: presenceType,
        fromId: myId);
    var payload = jsonEncode(presenceMessage.toJson());
    clientHandler.sendPayload(payload, myId.toPresenceTopic);
  }
}
