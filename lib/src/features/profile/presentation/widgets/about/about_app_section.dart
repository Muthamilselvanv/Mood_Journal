import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isDark
            ? const LinearGradient(
                colors: [Color(0xff2D2A4A), Color(0xff1F2937)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isDark ? null : Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: .08)
              : Theme.of(context).dividerColor.withValues(alpha: .35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ABOUT NILORA",
              style: TextStyle(
                color: isDark
                    ? Colors.white70
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 16),

            _item(
              icon: LucideIcons.info,
              title: "About Nilora",
              subtitle: "Our purpose and app information",
              onTap: () => Get.toNamed(AppRoutes.about),
            ),

            _item(
              icon: LucideIcons.shield,
              title: "Privacy Policy",
              subtitle: "How your data and privacy are protected",
              onTap: () => Get.toNamed(AppRoutes.privacy),
            ),

            _item(
              icon: LucideIcons.fileText,
              title: "Terms & Conditions",
              subtitle: "Rules for using Nilora",
              onTap: () => Get.toNamed(AppRoutes.terms),
            ),

            _item(
              icon: LucideIcons.messageCircle,
              title: "Contact Support",
              subtitle: "Questions, feedback, or technical help",
              onTap: () => Get.toNamed(AppRoutes.support),
            ),

            if (!(GetStorage().read<bool>('isGuest') ?? false))
              _item(
                icon: LucideIcons.userCog,
                title: "Account & Data",
                subtitle: "Manage permanent account actions",
                onTap: () => Get.toNamed(AppRoutes.accountData),
              ),

            // _item(
            //   icon: LucideIcons.star,
            //   title: "Rate App",
            //   subtitle: "Share your feedback",
            //   onTap: () => Get.toNamed(AppRoutes.rate),
            // ),
            Divider(
              height: 28,
              color: isDark
                  ? Colors.white.withValues(alpha: .12)
                  : Theme.of(context).dividerColor,
            ),

            Center(
              child: Text(
                "Nilora · Version 1.0.0",
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.grey,
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
      minTileHeight: 68,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.moodNeutral.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: AppColors.moodNeutral, size: 21),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.chevron_right_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onTap: onTap,
    );
  }
}
