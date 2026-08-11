import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/services/share_service.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';

class JournalDetailPage extends StatelessWidget {
  final MoodEntry entry;

  const JournalDetailPage({super.key, required this.entry});

  Color get moodColor {
    switch (entry.mood) {
      case "Happy":
        return const Color(0xffFDB515);
      case "Calm":
        return const Color(0xff36C690);
      case "Neutral":
        return const Color(0xff5B9DFF);
      case "Sad":
        return const Color(0xff8B80F9);
      case "Angry":
        return const Color(0xffFF5A6E);
      default:
        return Colors.grey;
    }
  }

  String get moodEmoji {
    switch (entry.mood) {
      case "Happy":
        return "😊";
      case "Calm":
        return "😌";
      case "Neutral":
        return "😐";
      case "Sad":
        return "😔";
      case "Angry":
        return "😡";
      default:
        return "🙂";
    }
  }

  String get weatherEmoji {
    switch (entry.weather) {
      case "Sunny":
        return "☀️";
      case "Cloudy":
        return "☁️";
      case "Rainy":
        return "🌧️";
      case "Snowy":
        return "❄️";
      case "Windy":
        return "💨";
      case "Stormy":
        return "⛈️";
      default:
        return "🌤";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();
    final theme = Theme.of(context);
    //final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasActivities = entry.activities.any((e) => e.trim().isNotEmpty);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: theme.colorScheme.surface,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: Get.back,
                    ),
                  ),

                  const Spacer(),

                  Obx(() {
                    final index = controller.moodEntries.indexWhere(
                      (e) => e.id == entry.id,
                    );

                    if (index == -1) {
                      return const SizedBox.shrink();
                    }

                    final current = controller.moodEntries[index];

                    return CircleAvatar(
                      radius: 22,
                      backgroundColor: theme.colorScheme.surface,
                      child: Obx(() {
                        final isLoading =
                            controller.isFavoriteLoading[entry.id] == true;

                        if (isLoading) {
                          return const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }

                        return IconButton(
                          onPressed: () {
                            controller.toggleFavoriteEntry(entry);
                          },
                          icon: Icon(
                            current.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: current.isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                        );
                      }),
                    );
                  }),

                  const SizedBox(width: AppSpacing.space8),

                  CircleAvatar(
                    radius: 22,
                    backgroundColor: theme.colorScheme.surface,
                    child: IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () async {
                        await ShareService.shareMood(entry);
                      },
                    ),
                  ),

                  const SizedBox(width: AppSpacing.space8),

                  CircleAvatar(
                    radius: 22,
                    backgroundColor: theme.colorScheme.surface,
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () async {
                        final home = Get.find<HomeController>();

                        home.loadMoodForEdit(entry);

                        Get.toNamed(AppRoutes.addMoodEntry);

                        // if (result == true) {
                        //   // Reload updated data
                        //   await controller.loadEntries();
                        // }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.space24),

              //---------------------------------------
              // Hero Card
              //---------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [moodColor, moodColor.withOpacity(.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    Text(moodEmoji, style: const TextStyle(fontSize: 70)),

                    const SizedBox(height: AppSpacing.space8),

                    Text(
                      "Feeling ${entry.mood}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.space4),

                    Text(
                      DateFormat(
                        "EEEE, MMM dd • hh:mm a",
                      ).format(entry.createdAt),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.space20),

              //---------------------------------------
              // Mood Intensity
              //---------------------------------------
              _InfoCard(
                title: "Mood Intensity",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: entry.intensity / 10,
                              minHeight: 12,
                              color: moodColor,
                              backgroundColor: moodColor.withOpacity(.15),
                            ),
                          ),
                        ),

                        const SizedBox(width: AppSpacing.space12),

                        Text(
                          "${entry.intensity}/10",
                          style: TextStyle(
                            fontSize: 26,
                            color: moodColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.space16),

              //---------------------------------------
              // Weather
              //---------------------------------------
              _InfoCard(
                title: "Weather",
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: moodColor.withOpacity(.10),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        weatherEmoji,
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(width: AppSpacing.space16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.weather,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space4),

                          Text(
                            "Weather during your journal",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.space16),

              //---------------------------------------
              // Activities
              //---------------------------------------
              _InfoCard(
                title: "Activities",
                child: hasActivities
                    ? Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: entry.activities
                            .where((e) => e.trim().isNotEmpty)
                            .map(
                              (activity) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: moodColor.withOpacity(.12),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  activity,
                                  style: TextStyle(
                                    color: moodColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Icon(
                                LucideIcons.activity,
                                size: 40,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "No activities added",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: AppSpacing.space16),

              //---------------------------------------
              // Journal
              //---------------------------------------
              _InfoCard(
                title: "Journal",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (entry.title.isEmpty)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.searchX,
                              size: 36,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "No journal entries",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                            ),
                          ],
                        ),
                      )
                    else
                      Text(
                        entry.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),

                    const SizedBox(height: AppSpacing.space16),

                    Text(
                      entry.notes,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.grey,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              if (entry.imageUrl != null && entry.imageUrl!.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    File(entry.imageUrl!),
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],

              Center(
                child: Text(
                  "✨ Every day is a fresh start",
                  style: TextStyle(
                    color: moodColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildAddMoodButton(context, entry),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, MoodEntry entry) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          "Delete Journal",
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
      content: Text(
        "Are you sure you want to delete this journal entry?\n\nThis action cannot be undone.",
        style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text("Cancel")),

        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            Get.back();

            await Get.find<JournalController>().deleteEntry(entry);

            AppSnackbar.success("Journal deleted");

            Get.offNamed(AppRoutes.journal); // Back to Journal Page
          },
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}

Widget buildAddMoodButton(BuildContext context, MoodEntry entry) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () => _showDeleteDialog(context, entry),
      label: Text(
        "Delete",
        style: TextStyle(
          fontSize: 16,
          color: Colors.redAccent,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      icon: const Icon(Icons.delete, color: Colors.redAccent),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              fontSize: 12,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }
}
