import 'package:flutter/material.dart';

/// Semantic colour tokens for the Mood Journal design system.
///
/// Widgets should use these named tokens or Theme.of(context).colorScheme,
/// never raw hex values in presentation code.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF8B5CF6);
  static const primaryLight = Color(0xFFEDE9FE);
  static const primaryDim = Color(0xFFDDD6FE);
  static const skyBlue = Color(0xFF60A5FA);
  static const skyBlueLight = Color(0xFFDBEAFE);
  static const mintGreen = Color(0xFF34D399);
  static const mintLight = Color(0xFFD1FAE5);
  static const warmYellow = Color(0xFFFBBF24);
  static const yellowLight = Color(0xFFFEF3C7);
  static const coralRose = Color(0xFFFB7185);
  static const roseLight = Color(0xFFFFE4E6);

  // Surfaces
  static const appBackground = Color(0xFFF8F7FF);
  static const screenGradientEnd = Color(0xFFF0F7FF);
  static const surface = Color(0xFFFFFFFF);
  static const input = Color(0xFFF9FAFB);
  static const mutedSurface = Color(0xFFF3F4F6);

  // Text and borders
  static const heading = Color(0xFF1C1033);
  static const body = Color(0xFF374151);
  static const secondaryText = Color(0xFF4B5563);
  static const label = Color(0xFF6B7280);
  static const placeholder = Color(0xFF9CA3AF);
  static const inactive = Color(0xFFC4B5FD);
  static const hairline = Color(0xFFD1D5DB);

  // Special actions
  static const dangerSurface = Color(0xFFFFF1F2);
  static const ghostSurface = Color(0xFFF5F3FF);
  static const darkBackground = Color(0xFF171321);
  static const darkSurface = Color(0xFF221C31);
  static const darkText = Color(0xFFF8F7FF);

  static const moodHappy = Color(0xFFFFB648);
  static const moodCalm = Color(0xFF34D399);
  static const moodNeutral = Color(0xFF60A5FA);
  static const moodSad = Color(0xFF7B61FF);
  static const moodAngry = Color(0xFFFF5A5F);
}
