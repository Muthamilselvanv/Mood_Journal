import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

abstract final class AppGradients {
  static const primary = LinearGradient(
    colors: [AppColors.primary, AppColors.skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const screen = LinearGradient(
    colors: [AppColors.appBackground, AppColors.screenGradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const desktopPage = LinearGradient(
    colors: [AppColors.primaryLight, AppColors.skyBlueLight, AppColors.mintLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

abstract final class AppRadii {
  static const small = BorderRadius.all(Radius.circular(12));
  static const medium = BorderRadius.all(Radius.circular(16));
  static const large = BorderRadius.all(Radius.circular(24));
  static const full = BorderRadius.all(Radius.circular(9999));
}

abstract final class AppShadows {
  static const primary = [
    BoxShadow(color: Color(0x668B5CF6), blurRadius: 24, offset: Offset(0, 8)),
  ];
  static const card = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 2)),
  ];
}
