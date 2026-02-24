import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange,
    colorScheme: ColorScheme.light(
      primary: Colors.deepOrange,
      secondary: Colors.orange,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepOrange,
      secondary: Colors.orange,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
