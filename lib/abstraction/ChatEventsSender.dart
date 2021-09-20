import 'models/enums/ChatMarker.dart';
import 'models/ChatMessage.dart';

abstract class ChatEventsSender {
  void sendIsTyping(bool isTyping, String room);
  void sendChatMarker(String messageId, ChatMarker marker, String room);
  void sendChatMarkerOfMessage(
      ChatMessage message, ChatMarker marker, String bareRoom) {
    sendChatMarker(message.id, marker, bareRoom);
  }

  void sendInvitation(String username, String? invitationId);
  void respondToInvitation(String sednderId, bool accept);
}
