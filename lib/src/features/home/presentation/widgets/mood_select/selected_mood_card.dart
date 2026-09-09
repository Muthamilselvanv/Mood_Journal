import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';

class SelectedMoodCard extends GetView<HomeController> {
  const SelectedMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double scaleFactor = screenWidth / 360;

    double responsiveSize = 80 * scaleFactor;
    return Obx(() {
      final mood = controller.selectedMood;
      final color = mood?.color ?? Theme.of(context).colorScheme.primary;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          // Background changes automatically
          color: color.withValues(alpha: .12),
        ),

        child: Column(
          children: [
            Container(
              width: responsiveSize,
              height: responsiveSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  mood?.emoji ?? '🙂',
                  style: const TextStyle(
                    fontSize: AppIconSizes.extraLarge * 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            Text(
              mood?.title ?? 'Choose your mood',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            Text(
              mood == null
                  ? "Tap a mood below to begin"
                  : "Tap a mood below to change",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ],
        ),
      );
    });
  }
}
