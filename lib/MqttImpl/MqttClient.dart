import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_mqtt/MqttImpl/topics_generator.dart';
import 'package:flutter_mqtt/MqttImpl/utils.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/models/ContactChat.dart';
import 'package:flutter_mqtt/abstraction/models/PayloadWithTopic.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClient extends ClientHandler {
  MqttServerClient? _client;
  String? _clientId;
  User? _user;
  StreamController<PayloadWithTopic>? _messagesController;
  StreamController<ConnectionState>? _connectionController;
  @override
  Future<bool> connect(String username, String password) async {
    String cid = getClientId()!;
    _client = MqttServerClient.withPort(
        Platform.operatingSystem.toLowerCase() == 'android'
            ? '172.16.14.99'
            : 'localhost',
        cid,
        1883);
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

    _broadcastConnectionState();

    final connMessage = MqttConnectMessage()
        .authenticateAs(username, password)
        .withWillTopic('lastwills')
        .withWillMessage('Will message')
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connMessage;
    try {
      _broadcastConnectionState();

      await _client!.connect();

      _messagesController = StreamController<PayloadWithTopic>.broadcast();
      _connectionController =
          _connectionController = StreamController.broadcast();

      _subscribeToArchivesTopics();
      _broadcastConnectionState();
      _listenAndFilter();
      return true;
    } catch (e) {
      print('Exception: $e');
      _client!.disconnect();
      return false;
    }
  }

  void _subscribeToArchivesTopics() {
    _client!.subscribe(
        TopicsNamesGenerator.getArchivesRoomsTopic(getClientId()!),
        MqttQos.atLeastOnce);
    //_client!.subscribe(TopicsNamesGenerator.getArchivesMessagesTopic(getClientId()!), MqttQos.atLeastOnce);
    _client!.subscribe(
        TopicsNamesGenerator.getArchivesMyIdTopic(getClientId()!),
        MqttQos.atLeastOnce);
  }

  void _listenAndFilter() {
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      String topic = c[0].topic;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      _messagesController!
          .add(PayloadWithTopic(payload: payload, topic: topic));

      if (topic.toLowerCase().startsWith("archivesmyid/")) {
        try {
          String id = topic.split("/")[1];
          if (id == getClientId()) {
            _user = User.fromJson(payload);
          }
        } catch (e) {
          print("XXX Could not parse my id");
        }
      }

      print('Received message:$payload from topic: ${c[0].topic}>');
    });

    _client!.published!.listen((MqttPublishMessage message) {
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      _ackController!.add(payload);
    });
  }

  void _broadcastConnectionState() {
    _connectionController.add(fromMqttStatus(_client == null
        ? null
        : _client!.connectionStatus == null
            ? null
            : _client!.connectionStatus!.state));
  }

  @override
  String getUserId() {
    return _client!.clientIdentifier;
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
    String messagesTopic =
        TopicsNamesGenerator.getChattingTopicForBareRoom(bareRoom);
    String eventsTopic =
        TopicsNamesGenerator.getEventsTopicForBareRoom(bareRoom);

    _client!.subscribe(messagesTopic, MqttQos.atLeastOnce);
    _client!.subscribe(eventsTopic, MqttQos.atLeastOnce);
  }

  @override
  void joinContactEvents(String contactId) {
    _client!.subscribe("presence/" + contactId, MqttQos.atLeastOnce);
  }

  @override
  void sendPayload(String payload, String channel) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    _client!.publishMessage(channel, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  void disconnect() {
    try {
      _client!.disconnect();
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<PayloadWithTopic> allMessagesStream() {
    return _messagesController!.stream;
  }

  //==============

// connection succeeded
  void onConnected() {
    print('Connected');
    _broadcastConnectionState();
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
    _broadcastConnectionState();
    if (_messagesController != null && !_messagesController!.isClosed) {
      _messagesController!.close();
    }
    if (_ackController != null && !_ackController!.isClosed) {
      _ackController!.close();
    }
    _user = null;
    _client = null;
    _clientId = null;
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  //auto reconnect
  void onAutoReconnect() {
    print('Auto Reconnect');
    _broadcastConnectionState();
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  @override
  Stream<ConnectionState> connectionStateStream() {
    return _connectionController.stream;
  }

  @override
  Stream<String> acknowledgementsStream() {
    return _ackController!.stream;
  }

  @override
  String? getClientId() {
    if (_clientId == null) {
      _clientId = Platform.operatingSystem + "_f_client_" + _getRandomString(5);
    }
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
  User? getUser() {
    return _user;
  }
}
