import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:intl/intl.dart';

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invitations"),
      ),
      body: Container(
        child: StreamBuilder<List<DbInvitation>>(
            stream: AppData.instance()!.invitationsHandler.getInvitations(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                var invitations = snapshot.data;
                return ListView.builder(
                    itemCount: invitations!.length,
                    itemBuilder: (context, position) {
                      var inv = invitations[position];
                      return _invitationItem(inv);
                    });
              } else {
                return Text("Loading...");
              }
            }),
      ),
    );
  }

  Widget _invitationItem(DbInvitation inv) {
    var dt = DateTime.fromMillisecondsSinceEpoch(inv.sendTime);

    return ListTile(
      title: Text(inv.fromName ?? inv.fromId),
      subtitle: Text("Sent at: " + DateFormat('dd/MM/yyyy HH:mm').format(dt)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
