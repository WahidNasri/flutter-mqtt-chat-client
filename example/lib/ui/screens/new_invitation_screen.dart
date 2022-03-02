import 'package:flutter/material.dart';
import 'package:flutter_chat_mqtt/chat_app.dart';
import 'package:place_picker/uuid.dart';

class NewInvitationScreen extends StatefulWidget {
  const NewInvitationScreen({Key? key}) : super(key: key);

  @override
  _NewInvitationScreenState createState() => _NewInvitationScreenState();
}

class _NewInvitationScreenState extends State<NewInvitationScreen> {
  TextEditingController controller = TextEditingController();
  String invitationUpdate = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invite User")),
      body: Column(
        children: [
          const Text("Invitee username"),
          TextField(
            controller: controller,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "email",contentPadding: EdgeInsets.all(8)),
          ),
          ElevatedButton(onPressed: (){
           _sendInvitation();
          }, child: const Text("Invite")),
          Text(invitationUpdate)
        ],
      ),
    );
  }
  _sendInvitation(){
    String id = Uuid().generateV4();
    ChatApp.instance()!
        .eventsSender
        .sendInvitation(controller.text, id);

    ChatApp.instance()!
        .invitationHandler
        .invitationUpdatesStream()
        .listen((event) {
      if (event.id == id) {
        setState(() {
          invitationUpdate = event.text ?? "update";
        });
      }
    });
  }
}
