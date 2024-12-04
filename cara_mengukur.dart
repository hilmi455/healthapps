import 'package:flutter/material.dart';
import 'cekjantung.dart';

class CaraMengukurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.favorite,
                    size: 48,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "CARA MENGUKUR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Letakkan sensor pada pergelangan tangan Anda. "
                "Tahan hingga pengukuran selesai.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Saran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "1. Pastikan tangan Anda tidak basah dan menempel dengan baik.\n"
                "2. Hindari banyak gerakan saat pengukuran berlangsung untuk mencegah pembacaan yang tidak akurat.\n"
                "3. Jika hasil tidak terbaca, bersihkan sensor dan pastikan tangan Anda dalam kondisi kering sebelum mencoba lagi.\n"
                "4. Pastikan alat terhubung dengan baik ke perangkat untuk menghindari gangguan sinyal saat pengukuran.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => CekJantungPage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'SAYA MENGERTI',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
