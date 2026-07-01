import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum AppFontSize { small, medium, large }

/// Builds the app's light and dark [ThemeData]. Kept separate from widgets
/// so theming stays a single source of truth, driven by SettingsBloc.
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(AppFontSize fontSize) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardColor: AppColors.lightSurface,
      dividerColor: const Color(0xFFE5E5EF),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.lightTextPrimary, fontSize: 14),
        titleLarge: TextStyle(color: AppColors.lightTextPrimary, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: AppColors.lightTextPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(AppFontSize fontSize) {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardColor: AppColors.darkSurface,
      dividerColor: const Color(0xFF2A2939),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimary, fontSize: 14),
        titleLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      useMaterial3: true,
    );
  }
}
