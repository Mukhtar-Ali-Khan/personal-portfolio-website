import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headerTextStyle({Color color = Colors.white}) {
    return GoogleFonts.signikaNegative(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle montserratStyle(
      {required Color color, double fontSize = 24}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
  }

  static TextStyle headingStyles(
      {double fontSize = 36, Color color = Colors.white}) {
    return GoogleFonts.rubikMoonrocks(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 2,
    );
  }

  static TextStyle normalStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      letterSpacing: 1.7,
      height: 1.5,
    );
  }

  static TextStyle comfortaaStyle() {
    return GoogleFonts.comfortaa(
        fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey);
  }
}
