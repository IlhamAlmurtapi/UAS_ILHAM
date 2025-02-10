import 'package:flutter/material.dart';
import 'home_page.dart'; // Import halaman dashboard
import 'sign_up_page.dart'; // Import halaman Sign Up

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildLoginForm(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return const Image(
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      image: AssetImage('assets/Background.jpg'),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
                0.8), // Mengatur warna latar belakang dengan transparansi
            borderRadius: BorderRadius.circular(10.0), // Sudut melengkung
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0, 2), // Posisi bayangan
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ukuran kolom sesuai konten
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildUsernameField(),
              const SizedBox(height: 16.0),
              _buildPasswordField(),
              const SizedBox(height: 24.0),
              _buildLoginButton(context),
              const SizedBox(height: 16.0),
              _buildSignUpButton(context), // Tombol Sign Up
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        border: const OutlineInputBorder(),
        fillColor: Colors.white, // Atur warna latar belakang
        filled: true, // Mengaktifkan pengisian warna
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        fillColor: Colors.white, // Atur warna latar belakang
        filled: true, // Mengaktifkan pengisian warna
      ),
      obscureText: true,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String username = _usernameController.text;
        String password = _passwordController.text;

        // Validasi login
        if (username == 'ilham' && password == '12345') {
          // Navigasi ke dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Tampilkan AlertDialog jika login gagal
          _showLoginErrorDialog(context);
        }
      },
      child: const Text('Login'),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigasi ke halaman Sign Up
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      },
      child: const Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid username or password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
