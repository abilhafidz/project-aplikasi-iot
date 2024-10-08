import 'package:flutter/material.dart';
import 'mqtt_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Buzzer Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSwitched = false;
  final mqttService = MQTTService();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    setupMqtt();
  }

  Future<void> setupMqtt() async {
    await mqttService.setupMqtt().then((_) {
      setState(() {
        isConnected = true;
      });
    }).catchError((error) {
      setState(() {
        isConnected = false;
      });
      print("Error connecting to MQTT: $error");
    });
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IOT Buzzer Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Buzzer Status: ${isSwitched ? "ON" : "OFF"}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              isConnected ? "Connected to MQTT" : "Disconnected from MQTT",
              style: TextStyle(
                  fontSize: 18, color: isConnected ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  if (isSwitched) {
                    mqttService.publishMessage("ON");
                  } else {
                    mqttService.publishMessage("OFF");
                  }
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
