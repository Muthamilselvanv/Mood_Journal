import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryLight,
    brightness: Brightness.light,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  );
}
