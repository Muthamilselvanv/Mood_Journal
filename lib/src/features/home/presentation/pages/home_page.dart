import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/features/profile/presentation/controllers/profile_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/greeting.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/mood_selector.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final profileController = Get.find<ProfileController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.space20,
        toolbarHeight: AppSpacing.toolBarhight, // 70
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    greeting(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            // Stack(
            //   clipBehavior: Clip.none,
            //   children: [
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(LucideIcons.bell, size: AppIconSizes.medium),
            //     ),
            //     Positioned(
            //       top: 12,
            //       right: 15,
            //       child: Container(
            //         width: 8,
            //         height: 8,
            //         decoration: BoxDecoration(
            //           color: Colors.redAccent,
            //           shape: BoxShape.circle,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(width: AppSpacing.space8),
            Obx(() {
              final user = profileController.user.value;
              return GestureDetector(
                onTap: () {
                  Get.find<MainController>().changeTap(3);
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.white : Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary.withOpacity(.15),
                    backgroundImage: user?.profileImage != null
                        ? FileImage(File(user!.profileImage!))
                        : null,
                    child: user?.profileImage == null
                        ? Image.asset(
                            AppAssets.niloraIcon,
                            width: 230,
                            fit: BoxFit.contain,
                            color: AppColors.primary,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ],
        ),
      ),

      //body
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            children: [
              buildMoodCard(context),
              const SizedBox(height: AppSpacing.space20),
              const MoodSelector(title: "SELECT YOUR MOOD"), // from widget
              const SizedBox(height: AppSpacing.space20),
              buildAddMoodButton(context),
              const SizedBox(height: AppSpacing.space24),
              buildTodaySnapshot(context),
              const SizedBox(height: AppSpacing.space20),
              buildQuickStats(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMoodCard(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final width = MediaQuery.sizeOf(context).width;

  final cardHeight = (width * 0.48).clamp(
    180.0,
    220.0,
  ); //clamp -> means, a method used to restrict a number to a specific range

  final bigCircle = (width * 0.32).clamp(120.0, 150.0);
  final smallCircle = (width * 0.11).clamp(40.0, 50.0);

  return Container(
    width: double.infinity,
    height: cardHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xff2D2A4A), Color(0xff1F2937)]
            : const [Color(0xffEEF1FF), Color(0xffDDF8F1)],
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Top Right Big Circle
          Positioned(
            top: -bigCircle * 0.20,
            right: -bigCircle * 0.15,
            child: Container(
              width: bigCircle,
              height: bigCircle,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.deepPurpleAccent.withOpacity(.18)
                    : Colors.purple.withOpacity(.10),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Small Green Circle
          Positioned(
            top: cardHeight * 0.10,
            right: bigCircle * 0.75,
            child: Container(
              width: smallCircle,
              height: smallCircle,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.tealAccent.withOpacity(.15)
                    : Colors.teal.withOpacity(.25),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Bottom Blue Circle
          Positioned(
            bottom: -bigCircle * 0.20,
            right: -bigCircle * 0.10,
            child: Container(
              width: bigCircle,
              height: bigCircle,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.blueAccent.withOpacity(.12)
                    : Colors.lightBlue.withOpacity(.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Flower Emoji
          Positioned(
            bottom: 10,
            right: 5,
            child: Text("🌸", style: TextStyle(fontSize: bigCircle * 0.45)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DAILY CHECK-IN",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isDark
                        ? const Color(0xffB9A8FF)
                        : const Color(0xff7B61FF),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "How are you\nfeeling today?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),

                const Spacer(),

                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xff374151)
                              : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: isDark
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Text(
                            ["😊", "😌", "😐", "😔", "😡"][index],
                            style: const TextStyle(fontSize: 20),
                          ),
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
  );
}

// mood selector in Widget folder

//Add Butoon
Widget buildAddMoodButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: AppGradientButton(
      text: "Add Today's Mood",
      icon: Icons.add,
      onPressed: () {
        Get.toNamed(AppRoutes.addMoodEntry);
      },
    ),
  );
}

//Today's Snapshot
Widget buildTodaySnapshot(BuildContext context) {
  final controller = Get.find<HomeController>();
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Obx(
        () => Text(
          controller.snapshotTitle,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.small,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      const SizedBox(height: AppSpacing.space8),

      Obx(() {
        final latest = controller.latestMood.value;

        if (latest == null) {
          return Card(
            elevation: isDark ? 2 : 0,
            shadowColor: Colors.black.withOpacity(.35),
            child: Padding(
              padding: AppSpacing.card,
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      LucideIcons.notebookText,
                      size: AppIconSizes.large,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      "No mood recorded yet",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final mood = controller.moods.firstWhere((e) => e.title == latest.mood);

        final weather = controller.weathers.firstWhere(
          (e) => e.title == latest.weather,
        );

        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: isDark ? Colors.grey : Colors.white),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: AppSpacing.card,
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      mood.emoji,
                      style: const TextStyle(fontSize: 34),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            latest.mood,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppIconSizes.medium,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                          ),

                          const Spacer(),

                          Text(
                            "${latest.intensity}/10",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: mood.color),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        mood.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: AppIconSizes.tiny,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Text(weather.emoji),

                          const SizedBox(width: 6),

                          Text(
                            latest.weather,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),

                          const SizedBox(width: AppSpacing.space8),

                          Text(
                            "•",
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),

                          const SizedBox(width: AppSpacing.space4),

                          Text(
                            TimeOfDay.fromDateTime(
                              latest.createdAt,
                            ).format(context),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ],
  );
}

//Quick Stats
class StatsCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const StatsCard({
    super.key,
    required this.emoji,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isDark ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: AppSpacing.space8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildQuickStats(BuildContext context) {
  final controller = Get.find<JournalController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "QUICK STATS",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: AppIconSizes.small,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),

      const SizedBox(height: AppSpacing.space12),

      Obx(
        () => Row(
          children: [
            Expanded(
              child: StatsCard(
                emoji: "🔥",
                value: controller.activeDays.toString(),
                label: "Day Streak",
              ),
            ),

            const SizedBox(width: AppSpacing.space12),

            Expanded(
              child: StatsCard(
                emoji: "📖",
                value: controller.moodEntries.length.toString(),
                label: "Total Entries",
              ),
            ),

            const SizedBox(width: AppSpacing.space12),

            Expanded(
              child: StatsCard(
                emoji: "⭐",
                value: controller.averageMood.toStringAsFixed(1),
                label: "Avg Mood",
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
