import 'dart:async';

import 'package:flutter_mqchat/extensions/topics_extensions.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/interfaces/invitations_handler.dart';
import 'package:flutter_mqchat/models/base_message.dart';
import 'package:flutter_mqchat/models/invitation_message.dart';

class MqttInvitationHandler extends InvitationHandler {
  final ClientHandler clientHandler;
  final StreamController<InvitationMessage> _invitationsController =
      StreamController.broadcast();
  final StreamController<InvitationMessage> _invitationsUpdatesController =
      StreamController.broadcast();

  MqttInvitationHandler(this.clientHandler) {
    clientHandler.allMessagesStream().listen((payloadWithTopic) {
      String topic = payloadWithTopic.topic;
      if (topic.isPersonalEventTopic) {
        var bm = BaseMessage.fromString(payloadWithTopic.payload);
        //Check first if it is an invitation related topic
        if (bm.isInvitationEvent()) {
          InvitationMessage invitationMessage =
              InvitationMessage.fromString(payloadWithTopic.payload);
          if (bm.isInvitationResponseEvent()) {
            _invitationsUpdatesController.add(invitationMessage);
          } else {
            _invitationsController.add(invitationMessage);
          }
        }
      }
    });
  }
  @override
  Stream<InvitationMessage> invitationUpdatesStream() {
    return _invitationsUpdatesController.stream;
  }

  @override
  Stream<InvitationMessage> newInvitationsStream() {
    return _invitationsController.stream;
  }
}
