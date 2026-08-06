import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text("User not found"),
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
                "@${user.username}",
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
