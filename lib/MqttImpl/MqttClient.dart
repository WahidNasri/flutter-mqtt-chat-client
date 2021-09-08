import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_mqtt/MqttImpl/topics_generator.dart';
import 'package:flutter_mqtt/abstraction/ClientHandler.dart';
import 'package:flutter_mqtt/abstraction/models/PayloadWithTopic.dart';
import 'package:flutter_mqtt/abstraction/models/User.dart';
import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rxdart/rxdart.dart';

class MqttClient extends ClientHandler {
  MqttServerClient? _client;
  String? _clientId;
  User? _user;
  StreamController<PayloadWithTopic>? _messagesController =
      StreamController.broadcast();
  BehaviorSubject<ConnectionState> _cnxBehavior = BehaviorSubject<ConnectionState>();
  @override
  Future<bool> connect(
      {required String username,
      required String password,
      String? clientId}) async {
    String cid = clientId ?? getClientId()!;
    _clientId = cid;
    _client = MqttServerClient.withPort(
        Platform.operatingSystem.toLowerCase() == 'windows'
            ? 'localhost'
            : '172.16.14.99',
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

      _subscribeToArchivesTopics();
      _listenAndFilter();
      return true;
    } catch (e) {
      print('Exception: $e');
      _client!.disconnect();
      return false;
    }
  }

  void _subscribeToArchivesTopics() {
    Future.delayed(Duration(seconds: 3), (){
      _client!.subscribe(
          TopicsNamesGenerator.getArchivesRoomsTopic(getClientId()!),
          MqttQos.atLeastOnce);
      _client!.subscribe(
          TopicsNamesGenerator.getArchivesMessagesTopic(getClientId()!),
          MqttQos.atLeastOnce);
      _client!.subscribe(
          TopicsNamesGenerator.getArchivesMyIdTopic(getClientId()!),
          MqttQos.atLeastOnce);
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
  }
  _broadcastConnectionState(){
    if(_client == null){
      _cnxBehavior.add(ConnectionState.disconnected);
      return;
    }
    if(_client!.connectionStatus == null){
      _cnxBehavior.add(ConnectionState.disconnected);
      return;
    }
    switch(_client!.connectionStatus!.state){

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
  void leaveRoom(String bareRoom) {
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

    if(_client == null){
      return;
    }
    _client!.unsubscribe(messagesTopic);
    _client!.unsubscribe(eventsTopic);
  }

  @override
  void joinContactEvents(String contactId) {
    _client!.subscribe("presence/" + contactId, MqttQos.atLeastOnce);
  }

  @override
  void leaveContactEvents(String contactId) {
    if(_client == null){
      return;
    }
    _client!.unsubscribe("presence/" + contactId);
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
    _client = null;
    _clientId = null;
    _user = null;
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
    _broadcastConnectionState();
    print('Auto Reconnect');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
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

  @override
  Stream<ConnectionState> connectionStateStream() {
    return _cnxBehavior.stream;
  }
}
