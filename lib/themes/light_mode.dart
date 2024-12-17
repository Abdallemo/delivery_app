// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
    surface: Color(0xFFFFFDE7), // Soft creamy yellow for background
    primary: Color.fromARGB(255, 177, 136, 13), // Warm yellow for highlights (buttons, appbar, etc.)
    secondary: Color(0xFFFFE082), // Light yellow for cards or food item areas
    onSurface: Color(0xFF4E4E4E), // Default text color globally
    inversePrimary: Color(0xFF5D4037), // Contrast brown for icons or buttons
),
 scaffoldBackgroundColor: Color(0xFFFFFDE7), // Set the background color globally
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Headings
    bodyMedium: TextStyle(fontSize: 16), // Body text
    bodySmall: TextStyle(fontSize: 12), // Secondary/smaller text
  ),
);
