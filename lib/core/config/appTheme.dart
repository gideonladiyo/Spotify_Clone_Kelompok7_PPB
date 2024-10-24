import 'package:flutter/material.dart';
import 'package:spotify_group7/core/config/theme/appColors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBG,
    brightness: Brightness.light,
    fontFamily: 'Montserrat',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80)
        )
      )
    )
  );

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBG,
      brightness: Brightness.dark,
    fontFamily: 'Montserrat',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)))));
}