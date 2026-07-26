import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  
  static const double toolBarhight = 70;

  static const EdgeInsets screen = EdgeInsets.fromLTRB(20, 4, 20, 24);

  static const EdgeInsets card = EdgeInsets.all(16);

  static const EdgeInsets heroCard = EdgeInsets.all(20);
}

// class AppTextSizes {
//   AppTextSizes._();

//   static const double small = 12;
//   static const double medium = 16;
//   static const double large = 20;
//   static const double extraLarge = 24;
// }

class AppIconSizes {
  AppIconSizes._();

  static const double tiny = 12;
  static const double small = 16;
  static const double medium = 20;
  static const double large = 24;
  static const double extraLarge = 32;
}

class AppRadius {
  AppRadius._();

  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
}

class ResponsiveScreen {
  ResponsiveScreen._();

  static bool isSmallPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 360;

  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;

  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
}

// class ResponsiveSize {
//   ResponsiveSize._();

//   static double cardHeight(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     return (width * 0.48).clamp(180.0, 230.0);
//   }

//   static double heroCircle(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     return (width * 0.35).clamp(120.0, 150.0);
//   }

//   static double emoji(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     return (width * 0.11).clamp(38.0, 46.0);
//   }
// }
