import 'package:flutter/material.dart';
import 'cekjantung.dart'; // Mengimpor halaman Cek Jantung

class CaraMengukurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(16), // Sama dengan cara_suhu.dart
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Mengatur ukuran agar sesuai konten
              children: [
                // Ikon Hati dengan background merah bulat
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.favorite,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                const Text(
                  "CARA MENGUKUR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Instruction Text
                const Text(
                  "Letakkan sensor pada pergelangan tangan Anda.\n"
                  "Tahan hingga pengukuran selesai.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Saran Text
                const Text(
                  "Saran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Recommendations
                const Text(
                  "1. Pastikan tangan Anda tidak basah dan menempel dengan baik.\n\n"
                  "2. Hindari banyak gerakan saat pengukuran berlangsung untuk mencegah pembacaan yang tidak akurat.\n\n"
                  "3. Jika hasil tidak terbaca, bersihkan sensor dan pastikan tangan Anda dalam kondisi kering sebelum mencoba lagi.\n\n"
                  "4. Pastikan alat terhubung dengan baik ke perangkat untuk menghindari gangguan sinyal saat pengukuran.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Tombol "SAYA MENGERTI"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman Cek Jantung
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CekJantungPage()),
                    );
                  },
                  child: const Text(
                    "SAYA MENGERTI",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
