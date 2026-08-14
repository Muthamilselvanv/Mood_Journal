import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/insights_card/insights_card.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/monthly_average_chart.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/mood_breakdown_chart.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/trend_stats_grid.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/weekly_mood_chart.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class TrendsPages extends StatefulWidget {
  const TrendsPages({super.key});

  @override
  State<TrendsPages> createState() => _TrendsPagesState();
}

class _TrendsPagesState extends State<TrendsPages> {
  final trendsController = Get.find<TrendsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSpacing.toolBarhight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.space20,

        title: Text(
          "Mood Trends",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TrendStatsGrid(),
              const SizedBox(height: AppSpacing.space20),
              const WeeklyMoodChart(),
              const SizedBox(height: AppSpacing.space20),
              const MonthlyAverageChart(),
              const SizedBox(height: AppSpacing.space20),
              const MoodBreakdownChart(),
              const SizedBox(height: AppSpacing.space20),
              Obx(() {
                final hasMoodEntries =
                    trendsController.controller.moodEntries.isNotEmpty;

                if (!hasMoodEntries) {
                  return const SizedBox.shrink();
                }

                return const Column(
                  children: [
                    SizedBox(height: AppSpacing.space20),
                    InsightsCard(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
