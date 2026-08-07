import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  Widget buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withOpacity(.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.moodNeutral.withOpacity(.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(LucideIcons.info, color: AppColors.moodNeutral),
          ),

          const SizedBox(width: AppSpacing.space12),

          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),

          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.moodNeutral,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("App Information"), centerTitle: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xff3A2D63), const Color(0xff243B5E)]
                      : [const Color(0xffEEF2FF), const Color(0xffE0F2FE)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      LucideIcons.smartphone,
                      size: 46,
                      color: AppColors.moodNeutral,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space16),

                  Text(
                    "Nilora",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space4),

                  Text(
                    "Mood Journal Application",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.7),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.space20),

            buildTile(
              context,
              icon: LucideIcons.appWindow,
              title: "Application",
              value: "Nilora",
            ),

            buildTile(
              context,
              icon: LucideIcons.badgeInfo,
              title: "Version",
              value: "4.0.0",
            ),

            buildTile(
              context,
              icon: LucideIcons.box,
              title: "Build",
              value: "1",
            ),

            buildTile(
              context,
              icon: LucideIcons.smartphone,
              title: "Platform",
              value: "Flutter",
            ),

            buildTile(
              context,
              icon: LucideIcons.user,
              title: "Developer",
              value: "Muthamilselvan V",
            ),

            const SizedBox(height: AppSpacing.space20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    "Made with Flutter",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    "Built with ❤️ to help people understand and improve their emotional well-being through daily mood tracking.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.7),
                      height: 1.6,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
