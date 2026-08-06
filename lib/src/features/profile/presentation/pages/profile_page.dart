import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/achievement_section.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/logout_button.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              SizedBox(height: AppSpacing.space24),

              AchievementSection(),

              SizedBox(height: AppSpacing.space24),

              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
