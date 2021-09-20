import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/InvitationTable.dart';
import 'package:moor/moor.dart';
part 'invitation_dao.g.dart';

@UseDao(tables: [Invitations])
class InvitationDao extends DatabaseAccessor<MyDatabase>
    with _$InvitationDaoMixin {
  InvitationDao(MyDatabase attachedDatabase) : super(attachedDatabase);

  Future<int> addInvitation(DbInvitation cts) {
    return into(invitations).insertOnConflictUpdate(cts);
  }

  Stream<List<DbInvitation>> getAllInvitations() {
    return select(invitations).watch();
  }
}
