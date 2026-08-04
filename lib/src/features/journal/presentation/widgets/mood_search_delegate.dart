import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class MoodSearchDelegate extends SearchDelegate {
  final controller = Get.find<JournalController>();

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ""),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildResults(context);

  Widget _buildResults(BuildContext context) {
    final keyword = query.trim().toLowerCase();

    List<MoodEntry> results = List.from(controller.moodEntries);

    if (controller.selectedFilter.value != "All") {
      results = results
          .where((e) => e.mood == controller.selectedFilter.value)
          .toList();
    }

    if (keyword.isNotEmpty) {
      results.sort((a, b) {
        final aScore = controller.searchScore(a, keyword);
        final bScore = controller.searchScore(b, keyword);
        return bScore.compareTo(aScore);
      });

      results = results
          .where((e) => controller.searchScore(e, keyword) > 0)
          .toList();
    }

    if (results.isEmpty) {
      return const Center(child: Text("No journals found"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return JournalCard(entry: results[index]);
      },
    );
  }
}
