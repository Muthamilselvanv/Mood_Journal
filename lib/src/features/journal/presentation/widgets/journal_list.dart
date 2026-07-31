import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class JournalList extends GetView<JournalController> {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.moodEntries.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(LucideIcons.notebookText, color: AppColors.coralRose, size: AppIconSizes.extraLarge,),
                SizedBox(height: AppSpacing.space12),
                Text(
                  "No journal entries yet",
                  style: TextStyle(fontSize: AppIconSizes.small, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.moodEntries.length,
        itemBuilder: (context, index) {
          return JournalCard(
            entry: controller.moodEntries[index], // ✅ Required parameter
          );
        },
      );
    });
  }
}
