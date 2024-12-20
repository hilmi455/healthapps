import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn = true;
  bool _obscurePassword = true;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Color _emailBorderColor = Colors.grey[200]!;
  Color _passwordBorderColor = Colors.grey[200]!;

  Future<void> _signIn() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      _showErrorSnackbar('Maaf, password yang Anda masukkan salah');
      setState(() {
        _passwordBorderColor =
            Colors.red; // Mengubah border menjadi merah pada password
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signUp() async {
    if (!_validateInputs(isSignUp: true)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isSigningIn = true;
        _emailBorderColor = Colors.grey[200]!; // Reset border color
        _passwordBorderColor = Colors.grey[200]!; // Reset border color
      });
      _showSuccessSnackbar('Anda berhasil membuat akun');
    } catch (e) {
      _showErrorSnackbar('Sign up gagal: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _validateInputs({bool isSignUp = false}) {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _showErrorSnackbar('Masukkan email yang valid');
      setState(() {
        _emailBorderColor = Colors.red; // Menambahkan border merah pada email
      });
      return false;
    }
    if (_passwordController.text.length < 6) {
      _showErrorSnackbar('Password minimal 6 karakter');
      setState(() {
        _passwordBorderColor =
            Colors.red; // Menambahkan border merah pada password
      });
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // Hapus teks "Sign In" dan "Sign Up" pada AppBar
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/image/hati.png',
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    if (_isSigningIn) ...[
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                    ],
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _emailBorderColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      onChanged: (_) {
                        // Reset border color when user starts typing
                        setState(() {
                          _passwordBorderColor = Colors.grey[200]!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isSigningIn ? _signIn : _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Ubah warna tombol menjadi merah
                      ),
                      child: Text(
                        _isSigningIn ? 'Login' : 'Create account',
                        style: TextStyle(
                            color: Colors.white), // Teks putih agar kontras
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_isSigningIn
                            ? "Belum mempunyai akun?"
                            : "Sudah mempunyai akun?"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSigningIn = !_isSigningIn;
                            });
                          },
                          child: Text(_isSigningIn ? 'Daftar' : 'Masuk'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
