import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

TextTheme buildAppTextTheme(TextTheme base) {
  return GoogleFonts.interTextTheme(base).copyWith(
    displaySmall: GoogleFonts.inter(
      textStyle: base.displaySmall,
      fontWeight: FontWeight.w800,
      color: AppColors.heading,
    ),
    headlineSmall: GoogleFonts.inter(
      textStyle: base.headlineSmall,
      fontWeight: FontWeight.w700,
      color: AppColors.heading,
    ),
    titleLarge: GoogleFonts.inter(
      textStyle: base.titleLarge,
      fontWeight: FontWeight.w700,
      color: AppColors.heading,
    ),
    titleSmall: GoogleFonts.inder(
      textStyle: base.titleSmall,
      fontWeight: FontWeight.w100,
      color: AppColors.heading,
    ),
    bodyLarge: GoogleFonts.inter(
      textStyle: base.bodyLarge,
      color: AppColors.body,
    ),
    bodyMedium: GoogleFonts.inter(
      textStyle: base.bodyMedium,
      color: AppColors.body,
    ),
    bodySmall: GoogleFonts.inter(
      textStyle: base.bodySmall,
      color: AppColors.secondaryText,
    ),
  );
}
