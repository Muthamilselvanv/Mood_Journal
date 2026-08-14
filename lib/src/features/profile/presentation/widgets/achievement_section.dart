import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

import 'achievement_card.dart';

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACHIEVEMENTS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;
            final cardWidth = (constraints.maxWidth - spacing) / 2;

            return Obx(
              () => Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  AchievementCard(
                    width: cardWidth,
                    emoji: '🔥',
                    title: '${controller.activeDays} Day Streak',
                  ),
                  AchievementCard(
                    width: cardWidth,
                    emoji: '📖',
                    title: '${controller.moodEntries.length} Entries',
                  ),
                  AchievementCard(
                    width: cardWidth,
                    emoji: controller.hasFirstEntry ? '⭐' : '🔒',
                    title: controller.hasFirstEntry ? 'First Entry' : 'Locked',
                  ),
                  AchievementCard(
                    width: cardWidth,
                    emoji: controller.isMoodMaster ? '💪' : '🔒',
                    title: controller.isMoodMaster ? 'Mood Master' : 'Locked',
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
