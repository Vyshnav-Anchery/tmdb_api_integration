import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConstants {
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
  static TextStyle homeSubCategories =
      GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold);
}
