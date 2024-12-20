import 'package:flutter/material.dart';
import 'profile.dart';
import 'about.dart';
import 'cekjantung.dart';
import 'ceksuhutubuh.dart';
import 'login.dart';
import 'caramengukur.dart';
import 'cara_suhu.dart';
import 'p3k.dart';
import 'sehat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _imageUrl = 'assets/image/hati.png'; // Default image
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load image profile from Firebase Storage
  Future<void> _loadProfileImage() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String fileName = 'profile_pictures/${user.uid}.jpg';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        String downloadUrl = await ref.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
        });
      }
    } catch (e) {
      print("Error loading image: $e");
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi log out
  void _showLogOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin untuk keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pinkAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Go Sehat"), // Nama akun
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    _imageUrl), // Menampilkan gambar profil dari Firebase
              ),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap:
                  _showLogOutDialog, // Menampilkan dialog konfirmasi saat klik Log Out
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Go Sehat!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Apa Yang Ingin Anda Cek?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),

              // Modularisasi card untuk cek
              _buildCard(
                  'Cek Detak Jantung', 'heartbeat.gif', CaraMengukurPage()),
              _buildCard(
                  'Cek Suhu Tubuh', 'temperature.gif', MeasurementGuidePage()),
              _buildCard('Penanganan P3K', 'p3k.gif', P3KPage()),
              _buildCard('Pola Hidup Sehat', 'protec.gif', SehatPage()),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk modularisasi card
  Widget _buildCard(String title, String image, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  targetPage), // Navigasi ke halaman yang sesuai
        );
      },
      child: Container(
        height: 133,
        width: double.infinity,
        child: Card(
          color: Color(0xFFDFF5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/$image',
                  height: 70,
                  width: 70,
                ),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
