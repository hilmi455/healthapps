import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 248, 236, 236),
              const Color.fromARGB(255, 254, 15, 95)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Image.asset(
                  'assets/image/hati.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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
                          '2. Cek Suhu Tubuh',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
