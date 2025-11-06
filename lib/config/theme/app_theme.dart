import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.interTextTheme(
        base.textTheme,
      ).copyWith(
        headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.inter(fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w400),
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.redAccent,
        secondary: Colors.redAccent,
      ),
    );
  }
}
