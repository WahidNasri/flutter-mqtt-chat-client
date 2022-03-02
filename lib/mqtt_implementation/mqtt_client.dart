import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_mqchat/extensions/topics_extensions.dart';
import 'package:flutter_mqchat/interfaces/client_handler.dart';
import 'package:flutter_mqchat/models/enums.dart';
import 'package:flutter_mqchat/models/payload_with_topic.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mime/mime.dart';

class MqttClient extends ClientHandler {
  MqttServerClient? _client;
  String? _clientId;
  final StreamController<PayloadWithTopic>? _messagesController =
      StreamController.broadcast();
  final BehaviorSubject<ConnectionState> _cnxBehavior =
      BehaviorSubject<ConnectionState>();
  @override
  Future<bool> connect(
      {required host,
      required String username,
      required String password,
      String? clientId,
      int? port}) async {
    String cid = clientId ?? getClientId()!;
    _clientId = cid;
    _client = MqttServerClient.withPort(host, cid, port ?? 1883);
    // _client = MqttServerClient.withPort('broker.emqx.io', resource, 1883

    _client!.logging(on: true);

    _client!.onConnected = onConnected;
    _client!.onDisconnected = onDisconnected;
    _client!.onUnsubscribed = onUnsubscribed;
    _client!.onSubscribed = onSubscribed;
    _client!.onSubscribeFail = onSubscribeFail;
    _client!.onAutoReconnect = onAutoReconnect;
    _client!.pongCallback = pong;
    _client!.keepAlivePeriod = 60;
    _client!.autoReconnect = true;

    final connMessage = MqttConnectMessage()
        .authenticateAs(username, password)
        .withWillTopic('lastwills')
        .withWillMessage('Will message')
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connMessage;
    try {
      //_messagesController =  StreamController.broadcast();

      _broadcastConnectionState();

      await _client!.connect();

      _broadcastConnectionState();
      _listenAndFilter();

      if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
        _subscribeToArchivesTopics();
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      _client!.disconnect();
      return false;
    }
  }

  void _subscribeToArchivesTopics() {
    Future.delayed(const Duration(seconds: 3), () {
      //TODO:MAKE the time as configuration
      final String membersTopic =
          (getClientId() ?? "").toMembershipArchivesTopic;
      final String messagesArchiveTopic =
          (getClientId() ?? "").toMessagesArchiveTopic;
      final String meArchiveTopic =
          (getClientId() ?? "").toMyProfileArchiveTopic;
      _client!.subscribe(membersTopic, MqttQos.atLeastOnce);
      _client!.subscribe(messagesArchiveTopic, MqttQos.atLeastOnce);
      _client!.subscribe(meArchiveTopic, MqttQos.atLeastOnce);
    });
  }

  void _listenAndFilter() {
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      String topic = c[0].topic;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      _messagesController!
          .add(PayloadWithTopic(payload: payload, topic: topic));

      debugPrint('Received message:$payload from topic: ${c[0].topic}>');
    });
  }

  _broadcastConnectionState() {
    if (_client == null) {
      _cnxBehavior.add(ConnectionState.disconnected);
      return;
    }
    if (_client!.connectionStatus == null) {
      _cnxBehavior.add(ConnectionState.disconnected);
      return;
    }
    switch (_client!.connectionStatus!.state) {
      case MqttConnectionState.disconnecting:
        _cnxBehavior.add(ConnectionState.disconnecting);
        break;
      case MqttConnectionState.disconnected:
        _cnxBehavior.add(ConnectionState.disconnected);
        break;
      case MqttConnectionState.connecting:
        _cnxBehavior.add(ConnectionState.connecting);
        break;
      case MqttConnectionState.connected:
        _cnxBehavior.add(ConnectionState.connected);
        break;
      case MqttConnectionState.faulted:
        _cnxBehavior.add(ConnectionState.faulted);
        break;
    }
  }

  @override
  bool isConnected() {
    if (_client == null) {
      return false;
    }
    if (_client!.connectionStatus == null) {
      return false;
    }
    return _client!.connectionStatus!.state == MqttConnectionState.connected;
  }

  @override
  bool isConnecting() {
    if (_client != null && _client!.connectionStatus != null) {
      return _client!.connectionStatus!.state == MqttConnectionState.connecting;
    }
    return false;
  }

  @override
  void joinRoom(String bareRoom) {
    /*
     * By joining a room we join to:
     * Messages topic (for chat messages)
     * Events topic (for events like typing, chatmarker..)
     *
     */
    String messagesTopic = bareRoom.toChattingTopic;
    String eventsTopic = bareRoom.toRoomEventsTopic;

    _client!.subscribe(messagesTopic, MqttQos.atLeastOnce);
    _client!.subscribe(eventsTopic, MqttQos.atLeastOnce);
  }

  @override
  void leaveRoom(String bareRoom) {
    /*
     * By joining a room we join to:
     * Messages topic (for chat messages)
     * Events topic (for events like typing, chatmarker..)
     *
     */
    String messagesTopic = bareRoom.toChattingTopic;
    String eventsTopic = bareRoom.toRoomEventsTopic;

    if (_client == null) {
      return;
    }
    _client!.unsubscribe(messagesTopic);
    _client!.unsubscribe(eventsTopic);
  }

  @override
  void joinContactEvents(String contactId) {
    _client!.subscribe(contactId.toPresenceTopic, MqttQos.atLeastOnce);
  }

  @override
  void joinMyEvents(String myId) {
    _client!.subscribe(myId.toPersonalEventTopic, MqttQos.atLeastOnce);

    _client!.subscribe(myId.toMembershipArchivesTopic, MqttQos.atLeastOnce);
    _client!.subscribe(myId.toMessagesArchiveTopic, MqttQos.atLeastOnce);
  }

  @override
  void leaveContactEvents(String contactId) {
    if (_client == null) {
      return;
    }
    _client!.unsubscribe(contactId.toPresenceTopic);
  }

  @override
  void sendPayload(String payload, String channel) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    _client!.publishMessage(channel, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  void sendFilePayload(File file, String channel) {
    //TODO: review the format
    final bytes = file.readAsBytesSync();

    var mime = lookupMimeType(file.path);
    String base64Image = "data:" +
        (mime ?? "text/plain") +
        ";base64," +
        base64Encode(bytes) +
        "," +
        basename(file.path);

    sendPayload(base64Image, channel);
  }

  @override
  void disconnect() {
    try {
      _client!.disconnect();
      _messagesController?.close();
    } catch (e) {
      debugPrint(e.toString());
    }
    _client = null;
    _clientId = null;
  }

  @override
  Stream<PayloadWithTopic> allMessagesStream() {
    return _messagesController!.stream;
  }

  //==============

// connection succeeded
  void onConnected() {
    debugPrint('Connected');
    _broadcastConnectionState();
  }

// unconnected
  void onDisconnected() {
    debugPrint('Disconnected');
    _broadcastConnectionState();
    if (_messagesController != null && !_messagesController!.isClosed) {
      //_messagesController!.close();
    }
    _client = null;
    _clientId = null;
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    debugPrint('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    debugPrint('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    debugPrint('Unsubscribed topic: $topic');
  }

  //auto reconnect
  void onAutoReconnect() {
    _broadcastConnectionState();
    debugPrint('Auto Reconnect');
  }

// PING response received
  void pong() {
    debugPrint('Ping response client callback invoked');
  }

  @override
  String? getClientId() {
    _clientId ??= Platform.operatingSystem + "_f_client_" + _getRandomString(5);
    return _clientId;
  }

  String _getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  @override
  Stream<ConnectionState> connectionStateStream() {
    return _cnxBehavior.stream;
  }
}
