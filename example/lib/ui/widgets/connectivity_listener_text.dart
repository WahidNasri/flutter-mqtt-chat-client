import 'package:flutter/material.dart';
import 'package:flutter_chat_mqtt/chat_app.dart';
import 'package:flutter_chat_mqtt/models/enums.dart' as e;

class ConnectivityListenerText extends StatelessWidget {
  const ConnectivityListenerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<e.ConnectionState>(
        stream: ChatApp.instance()!.clientHandler.connectionStateStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 15),
            );
          } else if (snapshot.hasData) {
            return Text(snapshot.data.toString().split(".").last,
                style: const TextStyle(fontSize: 12));
          }
          return const Text("Loading Connection State...",
              style: TextStyle(fontSize: 15));
        });
  }
}
