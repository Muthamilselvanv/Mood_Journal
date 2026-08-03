import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class JournalList extends GetView<JournalController> {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entries = controller.filteredEntries;

      if (entries.isEmpty) {
        return const Center(child: Text("No journals found"));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return JournalCard(entry: entries[index]);
        },
      );
    });
  }
}
