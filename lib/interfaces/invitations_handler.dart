import 'package:flutter_chat_mqtt/models/invitation_message.dart';

abstract class InvitationHandler {
  Stream<InvitationMessage> newInvitationsStream();
  Stream<InvitationMessage> invitationUpdatesStream();
}
