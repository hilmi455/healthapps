import 'dart:convert';
import 'package:flutter/material.dart';
import 'mqtt_service.dart';

class CekJantungPage extends StatefulWidget {
  @override
  _CekJantungPageState createState() => _CekJantungPageState();
}

class _CekJantungPageState extends State<CekJantungPage> {
  String _bpmStatus = "-"; // Nilai BPM awal
  String _classification = ""; // Klasifikasi hasil pengukuran
  String _suggestion = ""; // Saran berdasarkan pengukuran
  String _connectionStatus = "Terputus"; // Status koneksi MQTT
  bool _isMeasuring = false; // Status pengukuran
  bool _measurementCompleted = false; // Status pengukuran selesai
  late MqttService _mqttService;
  int? _finalBpm; // Hasil BPM terakhir

  @override
  void initState() {
    super.initState();
    _mqttService = MqttService();

    // Dengarkan perubahan koneksi
    _mqttService.onConnectionChanged = (bool isConnected) {
      setState(() {
        _connectionStatus = isConnected ? "Terhubung" : "Terputus";
      });
    };

    // Dengarkan data detak jantung baru
    _mqttService.onHeartRateUpdated = (String jsonData) {
      print("Data diterima dari MQTT: $jsonData"); // Debugging
      var data = jsonDecode(jsonData);
      int bpm = (data['bpm'] ?? 0).toInt();
      if (_isMeasuring) {
        setState(() {
          _bpmStatus = bpm.toString();
          _finalBpm = bpm; // Simpan data BPM terakhir
        });
      }
    };

    // Hubungkan dan berlangganan ke topik MQTT hospital/heartRate
    _mqttService.connect();
  }

  @override
  void dispose() {
    _mqttService.disconnect(); // Putuskan koneksi MQTT saat halaman ditutup
    super.dispose();
  }

  void _classifyHeartRate(int bpm) {
    if (bpm < 60) {
      _classification = "Bradycardia (Detak Jantung Rendah)";
      _suggestion =
          "Segera konsultasikan ke dokter jika merasa pusing atau lemah.";
    } else if (bpm >= 60 && bpm <= 100) {
      _classification = "Normal";
      _suggestion = "Detak jantung Anda sehat. Tidak perlu tindakan khusus.";
    } else {
      _classification = "Tachycardia (Detak Jantung Tinggi)";
      _suggestion =
          "Istirahat yang cukup dan konsultasikan ke dokter jika berlanjut.";
    }
  }

  // Fungsi untuk memulai pengukuran selama 5 detik
  void _startMeasurement() {
    setState(() {
      _isMeasuring = true;
      _measurementCompleted = false;
      _bpmStatus = "-";
      _classification = "";
      _suggestion = "";
      _finalBpm = null; // Reset data BPM terakhir
    });

    // Kirim pesan MQTT ke perangkat untuk mulai mengukur
    _mqttService.publish('hospital/heartRate', jsonEncode({"action": "start"}));

    // Setelah 5 detik, berhenti mengukur dan gunakan hasil terakhir
    Future.delayed(Duration(seconds: 20), () {
      setState(() {
        _isMeasuring = false;
        _measurementCompleted = true;
        if (_finalBpm != null) {
          _bpmStatus = _finalBpm.toString(); // Tampilkan hasil BPM terakhir
          _classifyHeartRate(_finalBpm!); // Klasifikasikan hasil BPM
        } else {
          _bpmStatus = "-";
          _classification = "Tidak ada data";
          _suggestion = "Pastikan perangkat Anda terhubung dengan baik.";
        }
      });

      // Kirim pesan MQTT ke perangkat untuk berhenti mengukur
      _mqttService.publish(
          'hospital/heartRate', jsonEncode({"action": "stop"}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Detak Jantung'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: 20),
          Image.asset(
            'assets/image/heartbeat.gif',
            height: 150,
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),

          // Tombol "Klik untuk Mengukur"
          GestureDetector(
            onTap: _isMeasuring
                ? null
                : _startMeasurement, // Disable saat sedang mengukur
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _isMeasuring ? "Mengukur..." : "Klik untuk Mengukur",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Menampilkan hasil pengukuran jika sudah selesai
          if (_measurementCompleted && _bpmStatus != "-")
            Column(
              children: [
                Text(
                  "Pengukuran Selesai",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: _classification == "Normal"
                        ? Colors.green[100]
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _classification,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _classification == "Normal"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _suggestion,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
