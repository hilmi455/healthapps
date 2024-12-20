import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart'; // Pastikan LoginScreen sudah diimport

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = 'assets/image/hati.png'; // Ganti dengan hati.png
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists && userDoc['profilePicture'] != null) {
          setState(() {
            _imageUrl = userDoc['profilePicture'];
          });
        } else {
          setState(() {
            _imageUrl = 'assets/image/hati.png'; // Ganti dengan hati.png
          });
        }
      }
    } catch (e) {
      print("Error loading profile image: $e");
      setState(() {
        _imageUrl = 'assets/image/hati.png'; // Ganti dengan hati.png
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 40,
                backgroundImage: _imageUrl.startsWith('assets')
                    ? AssetImage(_imageUrl)
                    : NetworkImage(_imageUrl) as ImageProvider,
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),
              Text(
                'Go Sehat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                user?.email ?? 'No email',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),

              TextFormField(
                initialValue: user?.email,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16),

              OutlinedButton(
                onPressed: () {
                  _showChangePasswordDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text(
                      'Ubah Password',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showDeleteAccountDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Hapus Akun',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController _newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ubah Password"),
          content: TextField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password Baru'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _auth.currentUser
                      ?.updatePassword(_newPasswordController.text);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Anda berhasil mengubah password"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal mengubah password")),
                  );
                }
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hapus Akun"),
          content: Text(
              "Apakah Anda yakin ingin menghapus akun Anda? Tindakan ini tidak dapat dibatalkan."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Menghapus akun
                  await _auth.currentUser?.delete();

                  // Logout setelah akun berhasil dihapus
                  await _auth.signOut();

                  // Menutup dialog
                  Navigator.of(context).pop();

                  // Menampilkan notifikasi bahwa akun berhasil dihapus
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Akun berhasil dihapus"),
                      backgroundColor: Colors.red,
                    ),
                  );

                  // Kembali ke halaman login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal menghapus akun")),
                  );
                }
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
}
