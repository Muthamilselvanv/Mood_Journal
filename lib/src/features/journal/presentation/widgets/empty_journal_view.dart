import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class EmptyJournalView extends StatelessWidget {
  const EmptyJournalView({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.coralRose.withOpacity(0.10),
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
              "No journal entries yet",
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
              "Your thoughts and feelings will appear here.\n"
              "Start writing your first journal entry.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                height: 1.5,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 20),

            // Small decorative line
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.coralRose.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
