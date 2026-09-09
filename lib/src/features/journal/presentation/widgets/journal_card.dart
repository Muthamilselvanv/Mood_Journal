import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/presentation/pages/journal_detail_page.dart';

class JournalCard extends StatelessWidget {
  final MoodEntry entry;

  const JournalCard({super.key, required this.entry});

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Get.to(() => JournalDetailPage(entry: entry));
      },
      child: Card(
        elevation: isDark ? 2 : 0,
        shadowColor: Colors.black.withValues(alpha: .35),
        margin: const EdgeInsets.only(bottom: 18),
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: isDark
              ? BorderSide(color: Colors.white.withValues(alpha: .1))
              : BorderSide.none,
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left mood indicator
              Container(
                width: 6,
                height: 96,
                decoration: BoxDecoration(
                  color: moodColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(width: 16),

              // Emoji
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isDark
                      ? moodColor.withValues(alpha: .20)
                      : moodColor.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(moodEmoji, style: const TextStyle(fontSize: 34)),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                          ),
                        ),

                        if (entry.isFavorite)
                          const Icon(Icons.favorite, color: Colors.red),

                        const SizedBox(width: 8),

                        Icon(Icons.chevron_right, color: Colors.grey.shade400),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? moodColor.withValues(alpha: .20)
                                : moodColor.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            entry.mood,
                            style: TextStyle(
                              color: moodColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppIconSizes.small,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          weatherEmoji,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Text(
                          DateFormat("MMM dd, yyyy").format(entry.createdAt),
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: .65,
                            ),
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      entry.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.45,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .75,
                        ),
                        fontFamily: GoogleFonts.poppins().fontFamily,
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
