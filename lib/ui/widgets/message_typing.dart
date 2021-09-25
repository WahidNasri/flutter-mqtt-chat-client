import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageTyping extends StatelessWidget {
  final Function()? onAttachmentPressed;
  final Function(types.PartialText) onSendPressed;
  final Function(String)? onTextChanged;
  final Widget? topWidget;
  const MessageTyping({Key? key, this.onAttachmentPressed, required this.onSendPressed, this.onTextChanged, this.topWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      topWidget ?? SizedBox(),
      Input(
        isAttachmentUploading: false,
        onAttachmentPressed: onAttachmentPressed,
        onSendPressed: onSendPressed,
        onTextChanged: onTextChanged,
        //onTextFieldTap: widget.onTextFieldTap,
        sendButtonVisibilityMode: SendButtonVisibilityMode.editing,
      )
    ]);
  }
}
