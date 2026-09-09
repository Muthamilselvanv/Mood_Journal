import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: false,
      ),
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
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.description_rounded,
                      size: AppIconSizes.extraLarge * 2,
                      color: AppColors.moodNeutral,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space8),

                  Text(
                    "Terms & Conditions",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Please read these terms carefully before using Nilora.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .7),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    _TermTile(
                      icon: Icons.verified_user_outlined,
                      title: "Use the app responsibly.",
                    ),
                    Divider(height: 30),
                    _TermTile(
                      icon: Icons.lock_outline,
                      title: "Keep your account secure.",
                    ),
                    Divider(height: 30),
                    _TermTile(
                      icon: Icons.menu_book_outlined,
                      title: "Your journal entries belong to you.",
                    ),
                    Divider(height: 30),
                    _TermTile(
                      icon: Icons.system_update_alt_outlined,
                      title: "Features may change with future updates.",
                    ),
                    Divider(height: 30),
                    _TermTile(
                      icon: Icons.privacy_tip_outlined,
                      title:
                          "Your personal information is handled according to our Privacy Policy.",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "By continuing to use Nilora, you agree to these Terms & Conditions.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                height: 1.5,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _TermTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _TermTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.moodNeutral.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.check_circle_outline,
            color: AppColors.moodNeutral,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
