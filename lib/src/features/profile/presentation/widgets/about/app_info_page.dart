import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  late final Future<PackageInfo> _packageInfoFuture;

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = PackageInfo.fromPlatform();
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.moodNeutral.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.moodNeutral, size: 22),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.moodNeutral,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('App Information')),
      body: SafeArea(
        child: FutureBuilder<PackageInfo>(
          future: _packageInfoFuture,
          builder: (context, snapshot) {
            final packageInfo = snapshot.data;
            final version = packageInfo?.version ?? '1.0.0';
            final buildNumber = packageInfo?.buildNumber ?? '1';

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      colors: isDark
                          ? const [Color(0xff3A2D63), Color(0xff243B5E)]
                          : const [Color(0xffEEF2FF), Color(0xffE0F2FE)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          LucideIcons.smartphone,
                          size: 46,
                          color: AppColors.moodNeutral,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space16),
                      Text(
                        'Nilora',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'Mood Journal Application',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.space20),

                _buildTile(
                  context,
                  icon: LucideIcons.appWindow,
                  title: 'Application',
                  value: packageInfo?.appName ?? 'Nilora',
                ),
                _buildTile(
                  context,
                  icon: LucideIcons.badgeInfo,
                  title: 'Version',
                  value: version,
                ),
                _buildTile(
                  context,
                  icon: LucideIcons.box,
                  title: 'Build',
                  value: buildNumber,
                ),
                _buildTile(
                  context,
                  icon: LucideIcons.code2,
                  title: 'Framework',
                  value: 'Flutter',
                ),
                _buildTile(
                  context,
                  icon: LucideIcons.user,
                  title: 'Developer',
                  value: 'Muthamilselvan V',
                ),

                const SizedBox(height: AppSpacing.space12),

                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: Colors.redAccent,
                        size: 36,
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      Text(
                        'Made with Flutter',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      Text(
                        'Built with ❤️ to help people understand and improve '
                        'their emotional well-being through daily mood tracking.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          height: 1.6,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
