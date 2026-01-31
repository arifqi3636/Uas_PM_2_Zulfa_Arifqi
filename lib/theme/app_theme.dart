import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors - Green theme untuk pertanian
  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color primaryGreenDark = Color(0xFF1E8449);
  static const Color primaryGreenLight = Color(0xFF52BE80);

  // Secondary Colors & Accents
  static const Color accentGreen = Color(0xFF52BE80);
  static const Color accentBlue = Color(0xFF3498DB);
  static const Color accentOrange = Color(0xFFE67E22);
  static const Color accentBrown = Color(0xFF8B6F47);

  // Background Colors
  static const Color bgLight = Color(0xFFF0F8F0);
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLightBlue = Color(0xFFF0F7FF);

  // Text Colors
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textMedium = Color(0xFF666666);
  static const Color textLight = Color(0xFFCCCCCC);

  // Status Colors
  static const Color statusHealthy = Color(0xFF27AE60); // Hijau cerah
  static const Color statusModerate = Color(0xFFE67E22); // Orange cerah
  static const Color statusUnhealthy = Color(0xFFE74C3C); // Merah cerah

  // Alert Colors
  static const Color alertError = Color(0xFFE74C3C);
  static const Color alertWarning = Color(0xFFF39C12);
  static const Color alertSuccess = Color(0xFF27AE60);
  static const Color alertInfo = Color(0xFF3498DB);
  
  // Card & Component Colors
  static const Color cardBg = Color(0xFFFAFAFA);
  static const Color cardBorder = Color(0xFFE8E8E8);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: accentGreen,
        surface: bgWhite,
        error: statusUnhealthy,
      ),
      scaffoldBackgroundColor: bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryGreen),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        labelStyle: const TextStyle(color: textMedium),
      ),
      cardTheme: CardThemeData(
        color: bgWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textDark),
        bodyMedium: TextStyle(fontSize: 14, color: textMedium),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryGreenLight,
        secondary: accentGreen,
        surface: const Color(0xFF1E1E1E),
        error: statusUnhealthy,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryGreenLight,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreenLight,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreenLight,
          side: const BorderSide(color: primaryGreenLight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryGreenLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF2C2C2C),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryGreenLight, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFFBDBDBD)),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2C2C2C),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFBDBDBD)),
      ),
    );
  }
}
