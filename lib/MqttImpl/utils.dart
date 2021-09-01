import 'package:flutter_mqtt/abstraction/models/enums/ConnectionState.dart';
import 'package:mqtt_client/mqtt_client.dart';

ConnectionState fromMqttStatus(MqttConnectionState? state) {
  if (state == null) {
    return ConnectionState.disconnected;
  }
  switch (state) {
    case MqttConnectionState.connected:
      return ConnectionState.connected;
    case MqttConnectionState.connecting:
      return ConnectionState.connecting;
    case MqttConnectionState.disconnected:
      return ConnectionState.disconnected;
    case MqttConnectionState.disconnecting:
      return ConnectionState.disconnecting;
    case MqttConnectionState.faulted:
      return ConnectionState.faulted;
  }
}
