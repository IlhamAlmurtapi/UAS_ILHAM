import 'package:flutter/material.dart';
import 'home_page.dart'; // Import halaman dashboard

class SignUpPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildSignUpForm(context),
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

  Widget _buildSignUpForm(BuildContext context) {
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
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildUsernameField(),
              const SizedBox(height: 16.0),
              _buildEmailField(),
              const SizedBox(height: 16.0),
              _buildPasswordField(),
              const SizedBox(height: 24.0),
              _buildSignUpButton(context),
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

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
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

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String username = _usernameController.text;
        String email = _emailController.text;
        String password = _passwordController.text;

        // Validasi input
        if (username.isEmpty || email.isEmpty || password.isEmpty) {
          _showInputErrorDialog(context);
        } else {
          // Tampilkan dialog konfirmasi pendaftaran
          _showSignUpSuccessDialog(context);
        }
      },
      child: const Text('Sign Up'),
    );
  }

  void _showInputErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Error'),
          content: const Text('All fields must be filled.'),
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

  void _showSignUpSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Your account has been created successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ); // Navigasi ke halaman dashboard
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
