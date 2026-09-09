import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/services/firebase/firebase_auth_service.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: showLogoutDialog,
        icon: const Icon(Icons.logout_rounded),
        label: Text(
          "Log Out",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.redAccent,
          backgroundColor: isDark
              ? Colors.redAccent.withValues(alpha: .08)
              : const Color(0xffFFF5F5),
          side: BorderSide(color: Colors.redAccent.withValues(alpha: .35)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog() {
  final context = Get.context!;
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  Get.dialog(
    Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: .08)
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: .12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
                size: 38,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Log Out",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Are you sure you want to log out?\nYou'll need to sign in again to continue.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .7),
                height: 1.5,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: Get.back,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      Get.back();
                      await _logout();
                    },
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text("Log Out"),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

Future<void> _logout() async {
  try {
    await FirebaseAuthService.instance.logout();

    final box = GetStorage();
    const sessionKeys = <String>[
      'isLoggedIn',
      'isGuest',
      'firebaseUid',
      'userId',
      'name',
      'userName',
      'email',
    ];

    for (final key in sessionKeys) {
      await box.remove(key);
    }

    Get.offAllNamed(AppRoutes.login);
  } catch (_) {
    Get.snackbar(
      'Logout failed',
      'Unable to log out right now. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
