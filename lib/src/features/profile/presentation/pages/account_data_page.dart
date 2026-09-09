import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/delete_account_button.dart';

class AccountDataPage extends StatelessWidget {
  const AccountDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Account & Data')),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screen,
          children: [
            Text(
              'Permanent account actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'These controls affect your account and stored information. '
              'Review the details carefully before continuing.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            const DeleteAccountButton(),
          ],
        ),
      ),
    );
  }
}
