import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor:
    const Color(0xFFF5F5F5),

    primaryColor: Colors.yellow,

    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.yellow,
    ),
  );

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
    const Color(0xFF121212),

    fontFamily: 'Poppins',

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.yellow,
      brightness: Brightness.dark,
    ),
  );
}