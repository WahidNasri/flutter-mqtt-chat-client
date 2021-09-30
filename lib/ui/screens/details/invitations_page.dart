import 'package:flutter/material.dart';
import 'package:flutter_mqtt/db/appdata/AppData.dart';
import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/global/ChatApp.dart';
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
      leading: CircleAvatar(
        backgroundColor: inv.incoming ? Colors.red : Colors.green,
        child: Icon(
          inv.incoming ? Icons.arrow_downward : Icons.arrow_upward,
          size: 20,
          color: Colors.white,
        ),
      ),
      title: Text(inv.fromName ?? inv.fromId),
      subtitle: Text((inv.incoming ? "Received at: " : "Sent at: ") +
          DateFormat('dd/MM/yyyy HH:mm').format(dt)),
      trailing: !inv.incoming || inv.status == "accepted" || inv.status == "rejected"
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      ChatApp.instance()!
                          .eventsSender
                          .respondToInvitation(inv.id, inv.fromId,  true);
                      AppData.instance()!.invitationsHandler.updateInvitationStatus(inv.id, "accepted");
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
                IconButton(
                    onPressed: () {
                      ChatApp.instance()!
                          .eventsSender
                          .respondToInvitation(inv.id, inv.fromId,  false);
                      AppData.instance()!.invitationsHandler.updateInvitationStatus(inv.id, "rejected");
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
    );
  }
}
