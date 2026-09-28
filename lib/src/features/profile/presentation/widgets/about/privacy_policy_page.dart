import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const _supportEmail = 'muthamilselvan251@gmail.com';
  static final _onlinePolicy = Uri.parse(
    'https://nilora-mood-journal-app.web.app/privacy',
  );

  Future<void> _openOnlinePolicy(BuildContext context) async {
    final opened = await launchUrl(
      _onlinePolicy,
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the online policy.')),
      );
    }
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, style: theme.textTheme.bodyMedium?.copyWith(height: 1.55)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 64,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nilora Privacy Policy',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Effective 14 September 2026',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _section(
              context,
              title: 'Who operates Nilora',
              body:
                  'Nilora is developed and operated by Muthamilselvan V. '
                  'Privacy questions and data requests can be sent to '
                  '$_supportEmail.',
            ),
            _section(
              context,
              title: 'Information processed for registered accounts',
              body:
                  'When you register, Nilora uses Firebase Authentication and '
                  'Cloud Firestore to process your email address, account '
                  'identifier, display name, profile biography, and account '
                  'timestamps. Your password is handled by Firebase '
                  'Authentication and is not stored in Nilora\'s local database.',
            ),
            _section(
              context,
              title: 'Mood and journal information',
              body:
                  'For signed-in users, mood, weather, activities, intensity, '
                  'journal title and notes, date, and favorite status are stored '
                  'in Cloud Firestore and cached in a local SQLite database. '
                  'This data is used to provide journal history, search, '
                  'favorites, statistics, trends, and restoration after reinstall.',
            ),
            _section(
              context,
              title: 'Guest mode',
              body:
                  'Guest mood and journal entries are stored only in the local '
                  'SQLite database on the device and are not sent to Firebase. '
                  'Guest data is not restored after uninstalling the app or '
                  'clearing its storage.',
            ),
            _section(
              context,
              title: 'Photos and device permissions',
              body:
                  'Nilora requests camera or photo access only when you choose '
                  'to attach an image. Profile and journal image files remain '
                  'on the device in the current version and are not uploaded. '
                  'They are not restored after uninstalling Nilora or changing devices.',
            ),
            _section(
              context,
              title: 'Service providers and sharing',
              body:
                  'Nilora uses Google Firebase as a service provider for '
                  'authentication and cloud data storage. Data is sent to '
                  'Firebase only as needed to provide those features. Nilora '
                  'does not sell personal data. If you use the Share feature, '
                  'you choose the receiving app and information to share.',
            ),
            _section(
              context,
              title: 'Storage, security, and retention',
              body:
                  'Cloud communication uses encrypted network connections. '
                  'Local data is stored in the app\'s device storage. No method '
                  'of storage is completely secure. Account and journal data is '
                  'retained while the account is active or until deletion is '
                  'requested, except where retention is legally required.',
            ),
            _section(
              context,
              title: 'Deletion and your choices',
              body:
                  'You can delete individual journal entries in the app. To '
                  'permanently delete your Nilora account and associated cloud '
                  'and local data, use Delete Account in the Profile screen. '
                  'You can also request help through Contact Support or email '
                  '$_supportEmail from your registered email address. Local '
                  'guest data can be removed by clearing app storage or '
                  'uninstalling Nilora.',
            ),
            _section(
              context,
              title: 'Policy updates',
              body:
                  'This policy may be updated when Nilora\'s features or data '
                  'practices change. The effective date above identifies the '
                  'current in-app version.',
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openOnlinePolicy(context),
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('View policy online'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
