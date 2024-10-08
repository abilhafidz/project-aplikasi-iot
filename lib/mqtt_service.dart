import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService {
  late MqttServerClient client;

  MQTTService() {
    client = MqttServerClient('192.168.1.10', 'FlutterClient');
    client.port = 1883;
    client.logging(on: true);
  }

  Future<void> setupMqtt() async {
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
    } else {
      print('Connection failed');
      client.disconnect();
    }
  }

  void publishMessage(String message) {
    final mqtt.MqttClientPayloadBuilder builder = mqtt.MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage('buzzer/control', mqtt.MqttQos.atLeastOnce, builder.payload!);
  }

  void disconnect() {
    client.disconnect();
  }
}
