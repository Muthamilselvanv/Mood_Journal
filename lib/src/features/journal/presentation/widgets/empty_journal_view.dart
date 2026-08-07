import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class EmptyJournalView extends StatelessWidget {
  const EmptyJournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.notebookText,
            size: AppIconSizes.extraLarge,
            color: AppColors.coralRose,
          ),
          SizedBox(height: AppSpacing.space12),
          Text(
            "No journal entries yet",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,),
          ),
        ],
      ),
    );
  }
}