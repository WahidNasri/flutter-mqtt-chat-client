import 'package:flutter_mqchat/models/chat_message.dart';
import 'package:flutter_mqchat/models/enums.dart';

abstract class ChatEventsSender {
  void sendIsTyping(bool isTyping, String bareRoom);
  void sendChatMarker(String messageId, ChatMarker marker, String bareRoom);
  void sendChatMarkerOfMessage(
      ChatMessage message, ChatMarker marker, String bareRoom) {
    sendChatMarker(message.id, marker, bareRoom);
  }

  void sendInvitation(String username, String? invitationId);
  void respondToInvitation(String invitationId, String senderId, bool accept);
  void sendPresence(PresenceType presenceType, String myId);
}
