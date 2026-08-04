import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/presentation/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();

  final currentPage = 0.obs;

  final pages = [
    OnboardingModel(
      emoji: "😊",
      title: "Track Your Mood",
      subtitle:
          "Understand your emotions one day at a time with beautiful journaling.",
    ),
    OnboardingModel(
      emoji: "📖",
      title: "Write Your Journal",
      subtitle:
          "Capture your thoughts, activities and memories every single day.",
    ),
    OnboardingModel(
      emoji: "📈",
      title: "Discover Your Trends",
      subtitle: "Learn emotional patterns and improve your mental wellbeing.",
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
