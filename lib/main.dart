import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      home: LoginPage(), // Set the LoginPage as the home screen
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

/// A class for app constants.
class AppConstants {
  static const String appTitle = 'Login Dashboard App';
  static const String fontFamily =
      'DM Sans'; // Anda bisa menghapus ini jika tidak digunakan
}
