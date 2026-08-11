import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/profile/presentation/controllers/profile_controller.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class ProfileHeader extends GetView<ProfileController> {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final user = controller.user.value;

      if (user == null) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xffEEF2FF),
                  child: Image.asset(
                    AppAssets.niloraIcon,
                    width: 230,
                    fit: BoxFit.contain,
                    color: Color(0xff7C4DFF),
                  ),
                ),

                const SizedBox(height: AppSpacing.space4),

                Text(
                  "Guest User",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "@guest",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: AppSpacing.space12),

                Text(
                  "You're currently exploring Mood Journal as a guest.\n"
                  "Create an account to save your moods, profile, and achievements.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),

                const SizedBox(height: 28),

                AppGradientButton(
                  text: "Create Account",
                  icon: Icons.person_add_alt_1,
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.register);
                  },
                ),

                // SizedBox(
                //   width: double.infinity,
                //   child: FilledButton.icon(
                //     onPressed: () {
                //       Get.offAllNamed(AppRoutes.register);
                //     },
                //     icon: const Icon(Icons.person_add_alt_1),
                //     label: const Text("Create Account"),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }

      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            children: [
              ProfileAvatar(
                imagePath: user.profileImage,
                onTap: controller.pickProfileImage,
              ),

              const SizedBox(height: 20),

              Text(
                user.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "@${user.name}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),

              const SizedBox(height: 12),

              Text(
                (user.bio == null || user.bio!.isEmpty)
                    ? "Living one day at a time 🌿"
                    : user.bio!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              AppGradientButton(
                text: "Edit Profile",
                icon: Icons.edit_outlined,
                onPressed: controller.editProfile,
              ),
            ],
          ),
        ),
      );
    });
  }
}
