import 'dart:convert';
import 'package:flutter/material.dart';
import 'caramengukur.dart';
import 'mqtt_service.dart';

class CekJantungPage extends StatefulWidget {
  @override
  _CekJantungPageState createState() => _CekJantungPageState();
}

class _CekJantungPageState extends State<CekJantungPage> {
  String _bpmStatus = "-";
  String _lastMeasurementTime = "-";
  String _connectionStatus = "Terputus";
  late MqttService _mqttService;

  @override
  void initState() {
    super.initState();
    _mqttService = MqttService();

    _mqttService.onConnectionChanged = (bool isConnected) {
      setState(() {
        _connectionStatus = isConnected ? "Terhubung" : "Terputus";
      });
    };

    _mqttService.onHeartRateUpdated = (String jsonData) {
      var data = jsonDecode(jsonData);
      setState(() {
        _bpmStatus = data['bpm'].toString();
        _connectionStatus = data['status'];
        _lastMeasurementTime = _getCurrentTime();
      });
    };

    _mqttService.connect();
  }

  @override
  void dispose() {
    _mqttService.disconnect();
    super.dispose();
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Detak Jantung'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 16,
            child: Row(
              children: [
                Icon(
                  _connectionStatus == "Terhubung"
                      ? Icons.check_circle
                      : Icons.error,
                  color: _connectionStatus == "Terhubung"
                      ? Colors.green
                      : Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Status: $_connectionStatus',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Detak Jantung Anda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _bpmStatus,
                      style: TextStyle(fontSize: 48, color: Colors.black87),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.favorite, color: Colors.red, size: 30),
                    SizedBox(width: 8),
                    Text(
                      'BPM',
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Terakhir diukur: $_lastMeasurementTime',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CaraMengukurPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  child: Text('Cara Mengukur'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
