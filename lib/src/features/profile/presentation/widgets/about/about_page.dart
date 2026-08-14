import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("About Nilora"), centerTitle: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space8),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: isDark
                      ? const [Color(0xff2A2348), Color(0xff1F2B45)]
                      : const [
                          Color(0xffEEF2FF),
                          Color(0xffE0F2FE),
                          Color(0xffDCFCE7),
                        ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Image.asset(AppAssets.niloraIcon),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space4),

                  Text(
                    "Nilora",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Version 4.0.0",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.7),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "Track your emotions, preserve your memories, and discover healthier habits every day.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.space20),

            /// About Card
            Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Text(
                  "Nilora is your personal mood journal designed to help you understand your emotions, reflect on daily experiences, save memorable moments with photos, and build positive mental wellness habits. Your journal stays private and belongs only to you.",
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space20),

            _FeatureTile(
              icon: Icons.emoji_emotions_outlined,
              title: "Daily Mood Tracking",
              subtitle: "Record how you feel every day.",
            ),

            const SizedBox(height: AppSpacing.space12),

            _FeatureTile(
              icon: Icons.menu_book_outlined,
              title: "Personal Journal",
              subtitle: "Write thoughts and experiences.",
            ),

            const SizedBox(height: AppSpacing.space12),

            _FeatureTile(
              icon: Icons.photo_library_outlined,
              title: "Photo Memories",
              subtitle: "Attach photos to your journal.",
            ),

            const SizedBox(height: AppSpacing.space12),

            _FeatureTile(
              icon: Icons.insights_outlined,
              title: "Mood Analytics",
              subtitle: "Discover trends and insights.",
            ),

            const SizedBox(height: AppSpacing.space12),
            _FeatureTile(
              icon: Icons.lock_outline,
              title: "Private & Secure",
              subtitle: "Your journal remains yours.",
            ),

            const SizedBox(height: AppSpacing.space20),

            Text(
              "Made with ❤️ for mindful living.",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            Text(
              "© ${DateTime.now().year} Nilora",
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.moodNeutral.withOpacity(.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.moodNeutral),
            ),

            const SizedBox(width: AppSpacing.space16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
