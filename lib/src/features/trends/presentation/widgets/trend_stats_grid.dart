import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/trend_stat_card.dart';

class TrendStatsGrid extends StatelessWidget {
  const TrendStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.15,
      children: [
        Obx(
          () => TrendStatCard(
            emoji: "⭐",
            title: "AVG SCORE",
            value: controller.averageMood.toStringAsFixed(1),
            backgroundColor: Color(0xffFFF8E6),
            borderColor: Color(0xffFFE39A),
          ),
        ),

        Obx(
          () => TrendStatCard(
            emoji: "🔥",
            title: "LONGEST STREAK",
            value: "${controller.longestStreak} days",
            backgroundColor: Color(0xffFFF2F2),
            borderColor: Color(0xffFFD0D0),
          ),
        ),

        Obx(
          () => TrendStatCard(
            emoji: "📖",
            title: "TOTAL ENTRIES",
            value: controller.moodEntries.length.toString(),
            backgroundColor: Color(0xffEEF5FF),
            borderColor: Color(0xffCFE0FF),
          ),
        ),

        Obx(
          () => TrendStatCard(
            emoji: "😊",
            title: "MOST COMMON",
            value: controller.mostCommonMood,
            backgroundColor: Color(0xffECFFF4),
            borderColor: Color(0xffC8F1D8),
          ),
        ),
      ],
    );
  }
}
