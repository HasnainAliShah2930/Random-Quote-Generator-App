import 'package:flutter/material.dart';

/// Centralized color palette for the app, matching the design mockup
/// (purple primary, soft light background, deep dark mode).
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6C5DD3);
  static const Color primaryDark = Color(0xFF4B3FA8);
  static const Color heartRed = Color(0xFFFF5C7A);

  static const Color lightBackground = Color(0xFFF5F5FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF8E8EA8);

  static const Color darkBackground = Color(0xFF0F0E17);
  static const Color darkSurface = Color(0xFF1C1B2A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA0A0B8);

  // Used to color-code categories (Motivation, Success, Life, ...).
  static const List<Color> categoryColors = [
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFF3B82F6),
    Color(0xFFEC4899),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
  ];
}
