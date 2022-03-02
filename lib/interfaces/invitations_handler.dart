import 'package:flutter_mqchat/models/invitation_message.dart';

abstract class InvitationHandler {
  Stream<InvitationMessage> newInvitationsStream();
  Stream<InvitationMessage> invitationUpdatesStream();
}
