import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Gosehat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/image/hati.png', 
                width: 100, 
                height: 100, 
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Gosehat adalah aplikasi kesehatan inovatif yang dirancang untuk membantu pengguna menjaga keseimbangan hidup sehat dengan fitur-fitur canggih. Berikut adalah beberapa fitur utama dari Gosehat:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '1. Pendeteksi Detak Jantung\n'
                  '2. Cek Suhu Tubuh\n'
                  '3. Jadwal Makan dan Tidur',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Dengan antarmuka yang user-friendly dan informasi yang mudah diakses, Gosehat menjadi teman setia bagi siapa saja yang ingin menjalani gaya hidup sehat. Aplikasi ini tidak hanya memberikan data, tetapi juga wawasan yang bermanfaat untuk meningkatkan kesehatan secara keseluruhan.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}