import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/onboarding_controller.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/onboarding_item.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/page_indicator.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffEEF4FF), Color(0xffF7F5FF), Color(0xffEAFBF8)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              /// Skip Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () =>
                        controller.currentPage.value ==
                            controller.pages.length - 1
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              controller.pageController.animateToPage(
                                controller.pages.length - 1,
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text("Skip"),
                          ),
                  ),
                ),
              ),

              /// PageView
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
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

              /// Bottom Card
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.70),
                  borderRadius: BorderRadius.circular(30),

                  border: Border.all(color: Colors.white.withOpacity(.4)),
                ),

                child: Column(
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

                    const SizedBox(height: 28),

                    /// Next Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.nextPage,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff7C4DFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: Text(
                            controller.currentPage.value ==
                                    controller.pages.length - 1
                                ? "Get Started"
                                : "Next",

                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
