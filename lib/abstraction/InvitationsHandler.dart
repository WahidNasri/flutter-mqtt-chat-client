import 'package:flutter_mqtt/abstraction/models/InvitationMessage.dart';

abstract class InvitationHandler {
  Stream<InvitationMessage> newInvitationsStream();
  Stream<InvitationMessage> invitationUpdatesStream();
}
