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
          "ACHIEVEMENTS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey,fontFamily: GoogleFonts.poppins().fontFamily,),
        ),

        const SizedBox(height: AppSpacing.space8),

        Obx(
          () => Row(
            children: [
              Expanded(
                child: AchievementCard(
                  emoji: "🔥",
                  title: "${controller.activeDays.toString()} Day\nStreak",
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: AchievementCard(
                  emoji: "📖",
                  title: "${controller.moodEntries.length.toString()} Entries",
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: AchievementCard(
                  emoji: controller.hasFirstEntry ? "⭐" : "🔒",
                  title: controller.hasFirstEntry ? "First Entry" : "Locked",
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AchievementCard(
                  emoji: controller.isMoodMaster ? "💪" : "🔒",
                  title: controller.isMoodMaster ? "Mood Master" : "Locked",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
