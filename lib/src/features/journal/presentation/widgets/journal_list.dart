import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class JournalList extends GetView<JournalController> {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entries = controller.filteredEntries;

      if (entries.isEmpty) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon container
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  "No journals found",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  "Your thoughts and feelings will appear here.\n",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
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
