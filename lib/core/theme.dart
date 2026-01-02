import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor
  AppTheme._();

  // Colors
  static const Color primaryBackground = Color(0xFF0B0F14);
  static const Color secondaryBackground = Color(0xFF111827);
  static const Color elevatedBackground = Color(0xFF1F2937);
  static const Color primaryText = Color(0xFFE5E7EB);
  static const Color secondaryText = Color(0xFF9CA3AF);
  static const Color mutedText = Color(0xFF6B7280);
  static const Color inverseText = Color(0xFF0B0F14);
  static const Color subtleBorder = Color(0xFF1F2937);
  static const Color primaryAccent = Color(0xFF4F46E5);

  // Typography
  static const String fontFamily = 'Inter';

  static TextTheme get _textTheme => const TextTheme(
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: primaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: primaryText,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      height: 1.25,
      fontWeight: FontWeight.w600,
      color: primaryText,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      height: 1.2,
      fontWeight: FontWeight.w700,
      color: primaryText,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBackground,
    primaryColor: primaryAccent,
    colorScheme: const ColorScheme.dark(
      primary: primaryAccent,
      surface: secondaryBackground,
      onSurface: primaryText,
      // bg parameter does not exist in ColorScheme.dark constructor.
      // surface is the new background in M3 effectively, or we let scaffoldBackgroundColor handle main bg.
    ),
    textTheme: _textTheme,
    fontFamily: fontFamily,
    dividerTheme: const DividerThemeData(color: subtleBorder, thickness: 1),
    extensions: [
      // Can add custom theme extensions here if needed
    ],
  );

  // Light Theme (Optional/Placeholder for now, mapped to ensure no crashes if switched)
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryAccent,
    textTheme: _textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    fontFamily: fontFamily,
  );
}
