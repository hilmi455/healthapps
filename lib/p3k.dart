import 'package:flutter/material.dart';

class P3KPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penanganan P3K'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panduan Penanganan P3K',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.healing, color: Colors.redAccent),
                      title: Text('Luka Terbuka',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Bersihkan luka dengan air bersih mengalir dan gunakan antiseptik untuk mencegah infeksi. Pastikan untuk tidak menyentuh luka dengan tangan kotor. Setelah dibersihkan, tutup luka menggunakan perban steril untuk melindungi dari kotoran. Jika pendarahan tidak berhenti setelah beberapa menit, tekan dengan kain bersih atau kasa steril hingga darah berhenti. Jika luka besar, segera cari bantuan medis.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.local_fire_department,
                          color: Colors.orange),
                      title: Text('Luka Bakar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Segera dinginkan area luka bakar dengan air mengalir dingin (hindari menggunakan air es karena dapat merusak jaringan kulit). Dinginkan selama 10-15 menit untuk mengurangi rasa panas dan pembengkakan. Jangan mengoleskan pasta gigi, mentega, atau bahan lain ke luka bakar. Setelah itu, tutup luka dengan kain bersih atau kasa steril untuk mencegah infeksi. Jika luka bakar meluas atau dalam, segera hubungi tenaga medis.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.bloodtype, color: Colors.red),
                      title: Text('Pendarahan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Jika terjadi pendarahan, tekan area tersebut dengan kain bersih atau kasa steril untuk menghentikan darah. Pertahankan tekanan hingga darah berhenti. Jika terdapat benda tajam yang menancap pada luka, jangan dicabut karena dapat memperparah pendarahan. Stabilkan posisi benda dengan perban hingga bantuan medis tiba. Pastikan korban tetap tenang untuk mencegah kehilangan darah lebih banyak.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading:
                          Icon(Icons.accessibility_new, color: Colors.blue),
                      title: Text('Patah Tulang',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Jangan mencoba menggerakkan atau meluruskan area yang diduga patah tulang. Stabilkan posisi dengan menggunakan bidai atau kain yang diikat di kedua sisi tulang yang patah. Hindari memberikan tekanan langsung pada area yang patah. Jika patah tulang terjadi pada leher atau tulang belakang, jangan pindahkan korban kecuali dalam situasi darurat. Segera hubungi layanan medis untuk perawatan lebih lanjut.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.green),
                      title: Text('Tersedak',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Untuk mengatasi tersedak, berdirilah di belakang korban dan berikan lima pukulan keras di antara tulang belikat menggunakan tumit tangan. Jika ini tidak berhasil, lakukan manuver Heimlich dengan cara menekan perut korban tepat di atas pusar menggunakan kedua tangan yang dikepalkan. Untuk bayi, gunakan dua jari untuk memberikan tekanan lembut di dada. Segera hubungi medis jika benda asing tidak keluar atau korban kehilangan kesadaran.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.warning, color: Colors.purple),
                      title: Text('Keracunan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Jika korban keracunan, hindari memaksa korban untuk muntah kecuali disarankan oleh petugas medis. Jika bahan kimia masuk ke mata, segera bilas mata dengan air bersih yang mengalir selama setidaknya 15 menit. Jika korban menelan bahan berbahaya, periksa label produk untuk informasi pertolongan pertama dan segera hubungi pusat racun atau layanan darurat.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.pest_control, color: Colors.brown),
                      title: Text('Gigitan Serangga atau Hewan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Cuci area gigitan dengan sabun dan air mengalir untuk mengurangi risiko infeksi. Gunakan kompres dingin untuk mengurangi pembengkakan dan rasa sakit. Jika gigitan berasal dari hewan liar atau hewan yang dicurigai rabies, segera cari bantuan medis untuk mendapatkan vaksin anti rabies. Jika gigitan menyebabkan reaksi alergi seperti sesak napas atau pembengkakan parah, hubungi layanan darurat.'),
                    ),
                  ),
                  Card(
                    color: Color(0xFFF5F5F5),
                    child: ListTile(
                      leading: Icon(Icons.favorite, color: Colors.pinkAccent),
                      title: Text('Serangan Jantung',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Jika seseorang mengalami serangan jantung, segera hubungi layanan medis darurat. Bantu korban duduk dalam posisi yang nyaman dan longgarkan pakaian ketat. Jika korban pingsan dan tidak bernapas, lakukan resusitasi jantung paru (CPR) hingga bantuan medis tiba. Jangan biarkan korban berjalan atau melakukan aktivitas fisik selama menunggu bantuan.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
