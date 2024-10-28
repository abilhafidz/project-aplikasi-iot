import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mqtt_service.dart';

class SwitchState with ChangeNotifier {
  bool _servoState = false;
  final MqttService mqttService;

  SwitchState(this.mqttService) {
    mqttService.onConnectionChanged = _updateConnectionStatus;
    _loadSwitchStates();
  }

  bool get servoState => _servoState;

  void toggleServo(bool value) {
    _servoState = value;
    _saveSwitchState('servo', value);
    _publishStatus();
    notifyListeners();
  }

  Future<void> _saveSwitchState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<void> _loadSwitchStates() async {
    final prefs = await SharedPreferences.getInstance();
    _servoState = prefs.getBool('servo') ?? false;
    notifyListeners();
  }

  void _publishStatus() {

    mqttService.publish('smarthouse/servo', _servoState ? 'on' : 'off');
  }

  void _updateConnectionStatus(bool isConnected) {

    if (isConnected) {
      print('MQTT Connected');
    } else {
      print('MQTT Disconnected');
    }
  }
}
