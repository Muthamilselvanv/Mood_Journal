import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'achievement_card.dart';

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ACHIEVEMENTS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),

        const SizedBox(height: AppSpacing.space8),

        Row(
          children: const [
            Expanded(
              child: AchievementCard(emoji: "🔥", title: "7 Day\nStreak"),
            ),

            SizedBox(width: 12),

            Expanded(
              child: AchievementCard(emoji: "📖", title: "10 Entries"),
            ),

            SizedBox(width: 12),

            Expanded(
              child: AchievementCard(emoji: "⭐", title: "First Entry"),
            ),

            SizedBox(width: 12),

            Expanded(
              child: AchievementCard(emoji: "💪", title: "Mood Master"),
            ),
          ],
        ),
      ],
    );
  }
}
