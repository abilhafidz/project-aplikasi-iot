import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;
  Function(bool)? onConnectionChanged; 

  MqttService() {
    client = MqttServerClient('192.168.1.17', 'FlutterClient');
    client.port = 1883;
    client.logging(on: true);
    client.keepAlivePeriod = 20; 
    client.onConnected = _onConnected; 
    client.onDisconnected = _onDisconnected; 
  }

  Future<void> connect() async {
    final connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier("FlutterClient")
        .withWillTopic("willtopic")
        .withWillMessage("My will message")
        .startClean()
        .withWillQos(mqtt.MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      print('Connected');
      _notifyConnectionStatus(true); 
    } else {
      print('Connection failed');
      client.disconnect();
      _notifyConnectionStatus(false); 
    }
  }

  void _notifyConnectionStatus(bool isConnected) {
    if (onConnectionChanged != null) {
      onConnectionChanged!(isConnected); 
    }
  }

  
  void _onConnected() {
    print('MQTT Connected');
    _notifyConnectionStatus(true); 
  }

  
  void _onDisconnected() {
    print('MQTT Disconnected');
    _notifyConnectionStatus(false); 
  }

  void subscribe(String topic) {
    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      client.subscribe(topic, mqtt.MqttQos.atLeastOnce);
    } else {
      print('Cannot subscribe, not connected');
    }
  }

  void publish(String topic, String message) {
    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      final mqtt.MqttClientPayloadBuilder builder = mqtt.MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, mqtt.MqttQos.atLeastOnce, builder.payload!);
    } else {
      print('Cannot publish, not connected');
    }
  }

  void disconnect() {
    client.disconnect();
  }
}
