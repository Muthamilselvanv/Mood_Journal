import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class MoodFilter extends GetView<JournalController> {
  const MoodFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final mood = controller.filters[index];

          return Obx(() {
            final selected = controller.selectedFilter.value == mood;

            return GestureDetector(
              onTap: () => controller.changeFilter(mood),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xff7C4DFF) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected
                        ? const Color(0xff7C4DFF)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    if (mood != "All") ...[
                      Text(_emoji(mood)),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      mood,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  String _emoji(String mood) {
    switch (mood) {
      case "Happy":
        return "😊";
      case "Calm":
        return "😌";
      case "Neutral":
        return "😐";
      case "Sad":
        return "😔";
      case "Angry":
        return "😡";
      default:
        return "";
    }
  }
}
