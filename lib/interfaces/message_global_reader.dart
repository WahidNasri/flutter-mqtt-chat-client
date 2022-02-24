import 'package:flutter_chat_mqtt/models/chat_marker_message.dart';
import 'package:flutter_chat_mqtt/models/chat_message.dart';
import 'package:flutter_chat_mqtt/models/presence_message.dart';
import 'package:flutter_chat_mqtt/models/typing_indicator_message.dart';


abstract class MessageGlobalReader {
  Stream<ChatMessage> getChatMessages();
  Stream<PresenceMessage> getPresenceMessages();
  Stream<TypingIndicatorMessage> getTypingMessages();
  Stream<ChatMarkerMessage> getChatMarkerMessages();

  Future<void> dispose();
}
