import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF00B14F); // Main green color
  static const primaryLight = Color(0xFFE6F7EB);
  static const textDark = Color(0xFF212121);
  static const textLight = Color(0xFF585858);
  static const textFaded = Color(0xFFAFAFAF);
  static const background = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFF5F5F5);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const border = Color(0xFFEEEEEE);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,

    // Font Theme
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      // For titles like "Login to Your Account"
      headlineSmall: GoogleFonts.poppins(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      // For subtitles like "Let's you in"
      headlineMedium: GoogleFonts.poppins(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      // For body text
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.textLight,
        fontSize: 14,
        height: 1.5,
      ),
      // For button text
      labelLarge: GoogleFonts.poppins(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: TextStyle(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    // TextField Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(
        color: AppColors.textFaded,
        fontSize: 14,
      ),
    ),
  );
}
