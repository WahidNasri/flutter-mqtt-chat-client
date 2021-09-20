import 'package:flutter_mqtt/db/database.dart';

class InvitationsHandler {
  Stream<List<DbInvitation>> getInvitations() {
    return MyDatabase.instance()!.invitationDao.getAllInvitations();
  }

  Stream<int> getInvitationsCount() {
    return getInvitations().map((event) => event.length);
  }
}
