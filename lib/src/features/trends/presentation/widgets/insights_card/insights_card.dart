import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';
import 'insight_tile.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrendsController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xffEEF2FF), Color(0xffE0F2FE), Color(0xffDCFCE7)],
        ),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("✨ INSIGHTS", style: Theme.of(context).textTheme.labelMedium),

            const SizedBox(height: 8),

            Text(
              "Your Mood Patterns",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 24),

            InsightTile(
              emoji: "😊",
              title: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Most common mood: "),
                    TextSpan(
                      text: controller.controller.mostCommonMood,
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            InsightTile(
              emoji: "📅",
              title: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Best day: "),
                    TextSpan(
                      text: controller.happiestDay,
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            InsightTile(
              emoji: "🌤",
              title: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Favorite weather: "),
                    TextSpan(
                      text: controller.favoriteWeather,
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            InsightTile(
              emoji: "💪",
              title: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Top activity: "),
                    TextSpan(
                      text: controller.favoriteActivity,
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            InsightTile(
              emoji: "🎉",
              title: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  children: [
                    const TextSpan(text: "Weekend insight: "),
                    TextSpan(
                      text: controller.weekendInsight,
                      style: const TextStyle(
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
