import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

ThemeData buildDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryDark,
    brightness: Brightness.dark,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  );
}
