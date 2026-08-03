import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xffEEF2FF), Color(0xffDDEEFF), Color(0xffDFFCF2)],
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 82,
                width: 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Color(0xff7C4DFF), Color(0xff5AA9FF)],
                  ),
                ),

                child: const Center(
                  child: Text(
                    "M",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Muthu",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Member since Jul 2026",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: controller.moodEntries.length.toString(),
                    title: "Journals",
                  ),
                ),

                SizedBox(width: 14),

                Expanded(
                  child: _StatCard(
                    value: controller.longestStreak.toString(),
                    title: "Day Streak",
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _StatCard(
                    value: controller.averageMood.toStringAsFixed(1),
                    title: "Avg Mood",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String title;

  const _StatCard({required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 5),

          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
