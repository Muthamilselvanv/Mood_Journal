import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xff171923),
                    Color(0xff1F2937),
                    Color(0xff16213E),
                  ]
                : const [
                    Color(0xffEEF4FF),
                    Color(0xffF7F5FF),
                    Color(0xffEAFBF8),
                  ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff7C4DFF).withValues(alpha: .18)
                      : const Color(0xff7C4DFF).withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: -120,
              left: -60,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff5AA9FF).withValues(alpha: .18)
                      : const Color(0xff5AA9FF).withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned.fill(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1200),
                      tween: Tween<double>(begin: 0.7, end: 1.0),
                      builder: (_, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(opacity: value, child: child),
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          // final isDark =
                          //     Theme.of(context).brightness == Brightness.dark;

                          return Image.asset(
                            isDark
                                ? AppAssets.logoHorizontalDark
                                : AppAssets.logoHorizontalLight,
                            width: 230,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
