import 'package:flutter/material.dart';

class SehatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pola Hidup Sehat'),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Artikel tentang Makan Sehat
            ArticleCard(
              title: 'Makan Sehat',
              description:
                  'Pola makan yang sehat sangat penting untuk menjaga tubuh tetap berfungsi dengan baik. Cobalah untuk mengonsumsi makanan bergizi yang meliputi berbagai macam buah, sayur, '
                  'protein, dan karbohidrat sehat. Pastikan untuk menghindari makanan yang mengandung gula tinggi, lemak jenuh, dan garam berlebih yang dapat merusak kesehatan jantung dan mempengaruhi berat badan. '
                  'Selain itu, makan dengan porsi yang seimbang dan pilih makanan yang kaya serat untuk mendukung pencernaan yang sehat.',
            ),
            // Artikel tentang Minum yang Cukup
            ArticleCard(
              title: 'Minum yang Cukup',
              description:
                  'Menjaga hidrasi tubuh sangat penting untuk menjalankan aktivitas sehari-hari. Tubuh kita terdiri dari lebih dari 60% air, jadi pastikan untuk minum air putih yang cukup setiap hari. '
                  'Selain itu, air juga membantu mengatur suhu tubuh, mengangkut nutrisi, dan membuang limbah dari tubuh. Hindari minuman manis yang berlebihan seperti soda, karena dapat meningkatkan kadar gula darah dan mempengaruhi kesehatan gigi.',
            ),
            // Artikel tentang Olahraga Rutin
            ArticleCard(
              title: 'Olahraga Rutin',
              description:
                  'Olahraga adalah salah satu kunci utama untuk menjaga kebugaran tubuh. Lakukan olahraga ringan hingga berat secara rutin seperti berjalan kaki, berlari, bersepeda, atau latihan kekuatan. '
                  'Olahraga membantu menjaga kesehatan jantung, meningkatkan kekuatan otot dan tulang, serta menurunkan risiko penyakit kronis seperti diabetes dan hipertensi. '
                  'Disarankan untuk berolahraga setidaknya 150 menit per minggu untuk menjaga kesehatan tubuh secara optimal.',
            ),
            // Artikel tentang Tidur yang Cukup
            ArticleCard(
              title: 'Tidur yang Cukup',
              description:
                  'Tidur yang cukup dan berkualitas sangat penting untuk pemulihan energi tubuh dan menjaga keseimbangan mental. Cobalah untuk tidur antara 7 hingga 9 jam setiap malam untuk memberi waktu bagi tubuh untuk melakukan perbaikan sel dan memperkuat sistem kekebalan tubuh. '
                  'Kurang tidur dapat menyebabkan gangguan kesehatan seperti penurunan konsentrasi, stres, dan meningkatkan risiko penyakit jantung. Mengatur rutinitas tidur yang konsisten akan membantu Anda tidur lebih nyenyak.',
            ),
            // Artikel tentang Menghindari Obat-Obatan Terlarang dan Minuman Keras
            ArticleCard(
              title: 'Menghindari Obat-Obatan Terlarang dan Minuman Keras',
              description:
                  'Selain menjaga pola makan, tidur, dan olahraga, salah satu hal yang sangat penting untuk menjaga kesehatan adalah menghindari penggunaan obat-obatan terlarang dan minuman keras. '
                  'Obat-obatan terlarang seperti heroin, kokain, dan methamphetamine dapat merusak sistem saraf pusat, mengganggu fungsi otak, dan menyebabkan ketergantungan yang sangat berbahaya. '
                  'Alkohol, jika dikonsumsi dalam jumlah berlebihan, dapat merusak hati, meningkatkan risiko terjadinya kanker, serta mempengaruhi kesehatan mental dan hubungan sosial. '
                  'Penting untuk memahami risiko-risiko tersebut dan mencari bantuan jika Anda merasa kesulitan untuk menjauhi kebiasaan buruk ini. Jauhi lingkungan yang dapat memicu kebiasaan tersebut, dan lakukan kegiatan positif untuk memperkuat mental dan emosional Anda.',
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;

  const ArticleCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink, // Mengubah warna teks menjadi merah muda
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 18, 17,
                      17), // Mengubah teks menjadi merah muda terang
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
