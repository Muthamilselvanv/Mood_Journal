import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';

class SelectedMoodCard extends GetView<HomeController> {
  const SelectedMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double scaleFactor = screenWidth / 360;

    double responsiveSize = 80 * scaleFactor;
    return Obx(() {
      final mood = controller.selectedMood;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          // Background changes automatically
          color: mood.color.withOpacity(.12),
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
                  mood.emoji,
                  style: const TextStyle(
                    fontSize: AppIconSizes.extraLarge * 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            Text(mood.title, style: Theme.of(context).textTheme.headlineSmall),

            const SizedBox(height: AppSpacing.space8),

            Text(
              "Tap a mood below to change",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    });
  }
}
