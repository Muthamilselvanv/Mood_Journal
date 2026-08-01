import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class JournalList extends GetView<JournalController> {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.moodEntries.length,
        itemBuilder: (context, index) {
          return JournalCard(
            entry: controller.moodEntries[index],
          );
        },
      );
    });
  }
}
