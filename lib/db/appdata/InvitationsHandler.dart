import 'package:flutter_mqtt/db/database.dart';

class InvitationsHandler {
  Stream<List<DbInvitation>> getInvitations() {
    return MyDatabase.instance()!.invitationDao.getAllInvitations();
  }

  Stream<int> getInvitationsCount() {
    return getInvitations().map((event) => event.length);
  }

  Future addInvitationRequest(String id) async {
    var user = await MyDatabase.instance()!.userDao.getUser();
    if (user == null) {
      return;
    }
    DbInvitation invitation = DbInvitation(
        id: id,
        fromId: user.id,
        sendTime: DateTime.now().millisecondsSinceEpoch,
        fromName: user.firstName + " " + user.lastName,
        incoming: false,
        status: "sent");
    await MyDatabase.instance()!.invitationDao.addInvitation(invitation);
  }
  Future updateInvitationStatus(String id, String status){
    return MyDatabase.instance()!.invitationDao.updateInvitationStatus(id, status);
  }
  void deleteInvitation(String id){
    MyDatabase.instance()!.invitationDao.deleteInvitation(id);
  }
  void deleteAll(){
    MyDatabase.instance()!.invitationDao.deleteAllInvitations();
  }
}
