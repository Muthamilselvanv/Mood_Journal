import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final version = packageInfo?.version ?? '...';
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ABOUT",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 16),

            _item(
              icon: LucideIcons.info,
              title: "About Mood Journal",
              subtitle: "Learn more about the app",
              onTap: () => Get.toNamed(AppRoutes.about),
            ),

            _item(
              icon: LucideIcons.shield,
              title: "Privacy Policy",
              subtitle: "Your data & privacy",
              onTap: () => Get.toNamed(AppRoutes.privacy),
            ),

            _item(
              icon: LucideIcons.fileText,
              title: "Terms & Conditions",
              subtitle: "Read our terms",
              onTap: () => Get.toNamed(AppRoutes.terms),
            ),

            _item(
              icon: LucideIcons.messageCircle,
              title: "Contact Support",
              subtitle: "Need help?",
              onTap: () => Get.toNamed(AppRoutes.support),
            ),

            // _item(
            //   icon: LucideIcons.star,
            //   title: "Rate App",
            //   subtitle: "Share your feedback",
            //   onTap: () => Get.toNamed(AppRoutes.rate),
            // ),
            const Divider(height: 28),

            Center(
              child: Text(
                "Mood Journal V1.0.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.moodNeutral),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
