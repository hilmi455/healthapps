import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'mqtt_service.dart';

void main() {
  runApp(CekSuhuTubuhApp());
}

class CekSuhuTubuhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CekSuhuTubuhScreen(),
    );
  }
}

class CekSuhuTubuhScreen extends StatefulWidget {
  @override
  _CekSuhuTubuhScreenState createState() => _CekSuhuTubuhScreenState();
}

class _CekSuhuTubuhScreenState extends State<CekSuhuTubuhScreen> {
  final MqttService mqttService = MqttService();
  List<double> temperatureReadings = [];
  String averageTemperature = "-";
  String lastTemperature = "-";
  String classification = "";
  String suggestion = "";
  String currentTime = "";
  bool isConnected = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadLastTemperature();
    mqttService.onTemperatureUpdated = (String newTemperature) {
      setState(() {
        _addTemperatureReading(double.tryParse(newTemperature) ?? 0);
      });
    };
    mqttService.onConnectionChanged = (bool connected) {
      setState(() {
        isConnected = connected;
      });
    };
    mqttService.connect();
    _startRealTimeClock();
  }

  @override
  void dispose() {
    mqttService.disconnect();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadLastTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastTemperature = prefs.getString('lastTemperature') ?? "-";
    });
  }

  Future<void> _saveLastTemperature(double temperature) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastTemperature', temperature.toStringAsFixed(1));
  }

  void _addTemperatureReading(double newTemperature) {
    temperatureReadings.add(newTemperature);
    if (temperatureReadings.length > 5) {
      temperatureReadings.removeAt(0);
    }
    _calculateAverageTemperature();
    _saveLastTemperature(newTemperature);
    setState(() {
      lastTemperature = newTemperature.toStringAsFixed(1);
    });
  }

  void _calculateAverageTemperature() {
    if (temperatureReadings.isNotEmpty) {
      double avg = temperatureReadings.reduce((a, b) => a + b) /
          temperatureReadings.length;
      averageTemperature = avg.toStringAsFixed(1);
      _classifyTemperature(avg);
    }
  }

  void _classifyTemperature(double temperature) {
    if (temperature < 30.0) {
      classification = "Suhu Rendah";
      suggestion =
          "Segera cari bantuan medis. Hangatkan tubuh dan hindari paparan dingin.";
    } else if (temperature >= 30.0 && temperature < 35.0) {
      classification = "Normal Rendah";
      suggestion =
          "Pantau kondisi tubuh, tetap hidrasi, dan gunakan pakaian hangat.";
    } else if (temperature >= 35.0 && temperature <= 37.5) {
      classification = "Normal";
      suggestion = "Suhu tubuh sehat. Tidak perlu tindakan khusus.";
    } else if (temperature > 37.5 && temperature <= 38.0) {
      classification = "Demam Ringan";
      suggestion =
          "Minum banyak cairan, istirahat cukup, dan cek suhu secara berkala.";
    } else if (temperature > 38.0 && temperature <= 39.0) {
      classification = "Demam Sedang";
      suggestion =
          "Gunakan obat penurun demam sesuai anjuran dokter dan tetap hidrasi.";
    } else {
      classification = "Demam Tinggi";
      suggestion =
          "Segera cari bantuan medis, terutama jika disertai gejala lain.";
    }
  }

  void _startRealTimeClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              isConnected ? Icons.wifi : Icons.wifi_off,
              color: isConnected ? Colors.green : Colors.red,
            ),
            SizedBox(width: 8),
            Text(
              isConnected ? 'Terhubung' : 'Terputus',
              style: TextStyle(color: isConnected ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),
          Column(
            children: [
              Text("Suhu Terakhir: $lastTemperature°C",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Rata-rata: $averageTemperature°C",
                  style: TextStyle(fontSize: 24)),
              SizedBox(height: 10),
              Text(classification,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(suggestion, textAlign: TextAlign.center),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(currentTime,
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
