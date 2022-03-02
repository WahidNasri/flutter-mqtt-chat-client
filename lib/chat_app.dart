import 'package:flutter_mqchat/interfaces/archive_handler.dart';
import 'package:flutter_mqchat/interfaces/chat_events_sender.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/interfaces/invitations_handler.dart';
import 'package:flutter_mqchat/interfaces/message_global_reader.dart';
import 'package:flutter_mqchat/interfaces/message_sender.dart';
import 'package:flutter_mqchat/interfaces/muc_handler.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_archive_handler.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_chat_events_sender.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_client.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_global_reader.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_invitation_handler.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_message_sender.dart';
import 'package:flutter_mqchat/mqtt_implementation/mqtt_muc_handler.dart';

class ChatApp {
  static ChatApp? _instance;

  late ClientHandler clientHandler;
  late MessageGlobalReader messageReader;
  late MessageSender messageSender;
  late ChatEventsSender eventsSender;
  late ArchiveHandler archiveHandler;
  late InvitationHandler invitationHandler;
  late MucHandler mucHandler;

  static ChatApp? instance() {
    _instance ??= ChatApp._();
    return _instance;
  }

  ChatApp._() {
    clientHandler = MqttClient();
    messageReader = MqttGlobalReader(clientHandler: clientHandler);
    messageSender = MqttMessageSender(clientHandler: clientHandler);
    eventsSender = MqttChatEventsSender(clientHandler: clientHandler);
    archiveHandler = MqttArchiveHandler(clientHandler: clientHandler);
    invitationHandler = MqttInvitationHandler(clientHandler);
    mucHandler = MqttMucHandler(clientHandler);
  }
  void disconnect() {
    clientHandler.disconnect();
    messageReader.dispose();
    archiveHandler.dispose();
  }
}
