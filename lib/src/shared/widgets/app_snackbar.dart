import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(String message) {
    Get.snackbar(
      icon: Icon(LucideIcons.check, color: Colors.white),
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  static void error(String message) {
    Get.snackbar(
      icon: Icon(LucideIcons.circleX, color: Colors.white),
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  static void warning(String message) {
    Get.snackbar(
      icon: Icon(LucideIcons.triangleAlert, color: Colors.white),
      "Warning",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  static void info(String message) {
    Get.snackbar(
      icon: Icon(LucideIcons.badgeInfo, color: Colors.white),
      "Info",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
