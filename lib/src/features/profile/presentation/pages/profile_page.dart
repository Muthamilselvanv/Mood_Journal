import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/achievement_section.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/logout_button.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_header.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_menu_section.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_menu_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            children: [
              ProfileHeader(),
              const SizedBox(height: AppSpacing.space20),
              AchievementSection(),
              const SizedBox(height: AppSpacing.space20),
              ProfileMenuSection(
                title: "PREFERENCES",
                items: [
                  ProfileMenuItem(
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    subtitle: "Daily reminder at 9:00 PM",
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: "Privacy & Lock",
                    subtitle: "Biometric lock enabled",
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space20),
              ProfileMenuSection(
                title: "DATA",
                items: [
                  ProfileMenuItem(
                    icon: Icons.cloud_upload_outlined,
                    title: "Backup & Restore",
                    subtitle: "Last backed up today",
                  ),
                  ProfileMenuItem(
                    icon: Icons.file_upload_outlined,
                    title: "Export Journal",
                    subtitle: "PDF or CSV format",
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space20),
              ProfileMenuSection(
                title: "MORE",
                items: [
                  ProfileMenuItem(
                    icon: Icons.info_outline,
                    title: "About Mood Journal",
                    subtitle: "Version 1.0.0",
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space20),
              LogoutButton(),
              const SizedBox(height: AppSpacing.space20),
            ],
          ),
        ),
      ),
    );
  }
}
