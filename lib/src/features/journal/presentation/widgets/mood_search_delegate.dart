import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
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
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Center(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon container
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.coralRose.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Icon(
                    LucideIcons.notebookText,
                    size: 42,
                    color: AppColors.coralRose,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                "No journals found",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                "We couldn't find any journal entries\n"
                "matching your search.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  height: 1.5,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 20),

              // Decorative line
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.coralRose.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      );
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
