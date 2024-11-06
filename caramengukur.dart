import 'package:flutter/material.dart';
import 'cekjantung.dart'; 

class CaraMengukurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cara Mengukur'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
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
                'assets/image/finger_print.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'CARA MENGUKUR',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tekan Sensor dengan salah satu ujung jari Anda. '
              'Tahan hingga pengukuran selesai.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Saran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Tetap berada di tempat terang atau nyalakan senter Anda agar pembacaan akurat.\n'
              '2. Tutup Lensa kamera dengan salah satu ujung jari Anda (bukan senternya, karena panas!).\n'
              '3. Santai dan Tahan hingga pengukuran berakhir.\n'
              '4. Kami akan mengukur detak jantung Anda dengan mendeteksi perubahan kecil dalam warna dan kecerahan ujung jari Anda.',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        CekJantungPage(), 
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'SAYA MENGERTI',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
