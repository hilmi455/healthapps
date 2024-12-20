import 'package:flutter/material.dart';
import 'dart:async';
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
  String temperature = "-";
  String classification = "";
  String suggestion = "";
  String currentTime = "";
  bool isConnected = false;
  bool isMeasuring = false;
  Timer? _calculationTimer;

  @override
  void initState() {
    super.initState();

    // Mengatur callback MQTT
    mqttService.onTemperatureUpdated = (String newTemperature) {
      if (isMeasuring) {
        _addTemperatureReading(double.tryParse(newTemperature) ?? 0);
      }
    };

    mqttService.onConnectionChanged = (bool connected) {
      setState(() {
        isConnected = connected;
      });
    };

    // Koneksi ke broker MQTT
    mqttService.connect();

    // Pembaruan waktu real-time
    _startRealTimeClock();
  }

  @override
  void dispose() {
    mqttService.disconnect();
    _calculationTimer?.cancel();
    super.dispose();
  }

  void _addTemperatureReading(double newTemperature) {
    setState(() {
      temperatureReadings.add(newTemperature);
    });
  }

  void _startMeasurement() {
    setState(() {
      isMeasuring = true;
      temperatureReadings.clear();
    });

    _calculationTimer = Timer(Duration(seconds: 5), () {
      if (temperatureReadings.isNotEmpty) {
        double avgTemp = temperatureReadings.reduce((a, b) => a + b) /
            temperatureReadings.length;
        setState(() {
          temperature = avgTemp.toStringAsFixed(1);
          _classifyTemperature(avgTemp);
          isMeasuring = false;
        });
      }
    });
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
    Timer.periodic(Duration(seconds: 1), (_) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/temperature.gif',
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                "Temperature: $temperature°C",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                currentTime,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              if (!isMeasuring)
                GestureDetector(
                  onTap: _startMeasurement,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Klik untuk mengukur",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              if (isMeasuring)
                Text(
                  "Mengukur...",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: classification.contains("Normal")
                      ? Colors.blue[100]
                      : Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      classification,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: classification.contains("Normal")
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      suggestion,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
