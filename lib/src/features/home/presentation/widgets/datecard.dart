import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/greeting.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

class Datecard extends StatelessWidget {
  const Datecard({super.key});
  @override
  Widget build(BuildContext context) {
    final today = formatAddDate();
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 360;
    double responsiveSize = 50 * scaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DATE',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Container(
          height: responsiveSize,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.calendar, color: AppColors.skyBlue),
              const SizedBox(width: AppSpacing.space16),
              Text(
                today,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
