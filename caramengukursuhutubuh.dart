import 'package:flutter/material.dart';

class CaraMengukurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cara Mengukur Suhu Tubuh'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Langkah-langkah untuk mengukur suhu tubuh:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/image/temperature.gif',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Nyalakan alat sensor suhu tubuh dengan menekan tombol daya (jika ada).',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Pastikan alat sudah siap digunakan. Biasanya, alat akan memberikan tanda seperti lampu indikator atau suara beep.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Arahkan sensor ke dahi atau area tubuh lainnya sesuai instruksi alat. Jarak ideal biasanya sekitar 1-5 cm.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '4. Tunggu beberapa detik hingga alat menunjukkan hasil suhu tubuh pada layar.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '5. Baca hasil suhu tubuh yang tertera pada layar alat. Hasil biasanya ditampilkan dalam derajat Celcius atau Fahrenheit.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Saran:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Jangan lupa membersihkan sensor sesuai petunjuk agar tetap higienis dan akurat.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Saya Mengerti',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
