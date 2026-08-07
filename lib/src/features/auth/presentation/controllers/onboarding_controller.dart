import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/features/auth/presentation/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();

  final currentPage = 0.obs;

  final pages = [
    OnboardingModel(
      image: AppAssets.onboardingScreen1,
      title: "Track Your Mood",
      subtitle:
          "Write down your thoughts and feelings in a calm, private space made just for you.",
    ),
    OnboardingModel(
      image: AppAssets.onboardingScreen2,
      title: "Track Your Mood",
      subtitle:
          "Turn everyday feelings into little notes, stickers, and memories worth keeping.",
    ),
    OnboardingModel(
      image: AppAssets.onboardingScreen3,
      title: "Track Your Mood",
      subtitle:
          "See your mood trends over time and discover what truly makes you feel your best.",
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
      final box = GetStorage();
      box.write("seenOnboarding", true);
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
