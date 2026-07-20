import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/app/theme/app_text_theme.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_design_tokens.dart';

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.heading,
    secondary: AppColors.skyBlue,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.skyBlueLight,
    surface: AppColors.surface,
    onSurface: AppColors.heading,
    error: AppColors.coralRose,
    onError: Colors.white,
    outline: AppColors.hairline,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.appBackground,
    textTheme: buildAppTextTheme(ThemeData.light().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBackground,
      foregroundColor: AppColors.heading,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.mutedSurface, space: 1),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.input,
      hintStyle: TextStyle(color: AppColors.placeholder),
      border: OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.mutedSurface),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.mutedSurface),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.full),
    ),
  );
}
