import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographCol {
  static final TextStyle h1 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle h2 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle h3 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  static final TextStyle h4 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final TextStyle h5 = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600
    )
  );

  static final TextStyle p1 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 14,
    ),
  );

  static final TextStyle p2 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 12,
    ),
  );
}
