import 'package:flutter_mqtt/abstraction/models/TypingMessage.dart';

import 'models/ChatMarkerMessage.dart';
import 'models/ChatMessage.dart';
import 'models/PresenceMessage.dart';

abstract class MessageOnlineReaderHandler {
  Stream<ChatMessage> getChatMessages();
  Stream<PresenceMessage> getPresenceMessages();
  Stream<TypingMessage> getTypingMessages();
  Stream<ChatMarkerMessage> getChatMarkerMessages();

  Future<void> dispose();
}
