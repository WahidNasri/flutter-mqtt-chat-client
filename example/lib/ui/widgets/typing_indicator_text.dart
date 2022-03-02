import 'package:flutter/material.dart';
import 'package:flutter_mqchat/chat_app.dart';
import 'package:flutter_mqchat/models/typing_indicator_message.dart';

class TypingIndicatorText extends StatelessWidget {
  final String currentUserId;
  final bool isGroup;
  final String roomId;
  final TextStyle? style;
  final Widget? fallbackWidget;
  const TypingIndicatorText(
      {Key? key,
      required this.isGroup,
      required this.roomId,
      this.style,
      required this.currentUserId,
      this.fallbackWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypingIndicatorMessage>(
        stream: ChatApp.instance()!.messageReader.getTypingMessages(),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data != null &&
                data.isTyping &&
                data.roomId == roomId &&
                data.fromId != currentUserId) {
              return Text(isGroup ? "$data.fromName is Typing" : "Typing...",
                  style: style ??
                      const TextStyle(fontSize: 12, color: Colors.grey));
            }
          }
          return fallbackWidget ?? Container();
        });
  }
}
