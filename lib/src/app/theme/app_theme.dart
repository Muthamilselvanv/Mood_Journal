import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/app/theme/dark_theme.dart';
import 'package:mood_journal_app/src/app/theme/light_theme.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => buildLightTheme();
  static ThemeData get darkTheme => buildDarkTheme();
}
