import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

TextTheme buildAppTextTheme(TextTheme base) => base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w900,
        color: AppColors.heading,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w800,
        color: AppColors.heading,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w800,
        color: AppColors.heading,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        color: AppColors.heading,
      ),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: 'Inter', color: AppColors.body),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: 'Inter', color: AppColors.body),
      bodySmall: base.bodySmall?.copyWith(fontFamily: 'Inter', color: AppColors.secondaryText),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        color: AppColors.heading,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        color: AppColors.label,
      ),
    );
