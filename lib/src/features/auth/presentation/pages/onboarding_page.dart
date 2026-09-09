import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/onboarding_controller.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/onboarding_item.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/page_indicator.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
            /// Top Right Circle
            Positioned(
              top: -120,
              right: -90,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff7C4DFF).withValues(alpha: .18)
                      : const Color(0xff7C4DFF).withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// Bottom Left Circle
            Positioned(
              bottom: -150,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff5AA9FF).withValues(alpha: .15)
                      : const Color(0xff5AA9FF).withValues(alpha: .08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  ///-----------------------
                  /// Skip Button
                  ///-----------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        if (controller.currentPage.value ==
                            controller.pages.length - 1) {
                          return const SizedBox();
                        }

                        return TextButton(
                          onPressed: () {
                            controller.pageController.animateToPage(
                              controller.pages.length - 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: isDark
                                ? const Color(0xffB9A8FF)
                                : const Color(0xff7C4DFF),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  ///-----------------------
                  /// PageView
                  ///-----------------------
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,

                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,

                      itemCount: controller.pages.length,

                      onPageChanged: controller.onPageChanged,

                      itemBuilder: (_, index) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: OnboardingItem(
                            key: ValueKey(index),
                            page: controller.pages[index],
                          ),
                        );
                      },
                    ),
                  ),

                  ///-----------------------
                  /// Bottom Card
                  ///-----------------------
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff1F2937).withValues(alpha: .90)
                          : Colors.white.withValues(alpha: .72),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: .08)
                            : Colors.white.withValues(alpha: .45),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isDark ? .25 : .04,
                          ),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Indicator
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.pages.length,
                              (index) => PageIndicator(
                                active: controller.currentPage.value == index,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * .03),

                        Obx(() {
                          final isLastPage =
                              controller.currentPage.value ==
                              controller.pages.length - 1;

                          if (!isLastPage) {
                            return Column(
                              children: [
                                Icon(
                                  Icons.swipe_left_rounded,
                                  color: isDark
                                      ? const Color(0xffB9A8FF)
                                      : const Color(0xff7C4DFF),
                                  size: 28,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Swipe to continue",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: .7),
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            );
                          }

                          return SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff7C4DFF),
                                    Color(0xff5AA9FF),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xff7C4DFF,
                                    ).withValues(alpha: .28),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: controller.nextPage,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
