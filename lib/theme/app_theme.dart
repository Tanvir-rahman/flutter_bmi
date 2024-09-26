import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color.fromRGBO(3, 71, 255, 1),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: 18, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
