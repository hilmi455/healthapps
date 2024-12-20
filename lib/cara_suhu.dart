import 'package:flutter/material.dart';
import 'ceksuhutubuh.dart'; // Pastikan mengimpor halaman ceksuhutubuh.dart

class MeasurementGuidePage extends StatelessWidget {
  const MeasurementGuidePage({Key? key}) : super(key: key);

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
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon + Header Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.thermostat,
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
                // Instruction
                const Text(
                  "Peganglah sensor dengan cara digenggam.\nTahan hingga pengukuran selesai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Subheader
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
                  "Pastikan tangan anda tidak basah dan genggamlah dengan baik.\n\n"
                  "Hindari banyak gerakan saat pengukuran berlangsung untuk mencegah pembacaan yang tidak akurat.\n\n"
                  "Jika hasil tidak terbaca, bersihkan sensor dan pastikan tangan Anda dalam kondisi kering sebelum mencoba lagi.\n\n"
                  "Pastikan alat terhubung dengan baik ke perangkat untuk menghindari gangguan sinyal saat pengukuran.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Button
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
                    // Navigasi ke halaman Cek Suhu Tubuh
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CekSuhuTubuhScreen()),
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
