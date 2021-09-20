import 'dart:async';
import 'dart:convert';

import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/InvitationsHandler.dart';
import 'package:flutter_mqtt/abstraction/models/BaseMessage.dart';
import 'package:flutter_mqtt/abstraction/models/InvitationMessage.dart';
import 'package:flutter_mqtt/abstraction/models/enums/InvitationMessageType.dart';

class MqttInvitationHandler extends InvitationHandler {
  final ClientHandler clientHandler;
  StreamController<InvitationMessage> _invitationsController =
      StreamController.broadcast();
  StreamController<InvitationMessage> _invitationsUpdatesController =
      StreamController.broadcast();

  MqttInvitationHandler(this.clientHandler) {
    clientHandler.allMessagesStream().listen((payloadWithTopic) {
      String topic = payloadWithTopic.topic;
      if (topic.startsWith("personalevents")) {
        String payload = payloadWithTopic.payload;
        var map = json.decode(payload);
        var bm = BaseMessage.fromJson(map);
        if (bm.isInvitationEvent()) {
          InvitationMessage invitationMessage = InvitationMessage.fromJson(map);
          if (invitationMessage.invitationMessageType ==
              InvitationMessageType.REQUEST_RESPONSE) {
            _invitationsController.add(invitationMessage);
          } else {
            _invitationsUpdatesController.add(invitationMessage);
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
