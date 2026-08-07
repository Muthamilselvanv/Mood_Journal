import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/add_mood_fab.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/empty_journal_view.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_list.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/mood_filter.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/mood_search_delegate.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSpacing.toolBarhight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.space20,

        title: Text(
          "Journal",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,),
        ),

        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MoodSearchDelegate());
            },
            icon: Icon(
              Icons.search_rounded,
              color: isDark? Colors.white:Colors.black,
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
        ],
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.moodEntries.isEmpty) {
            return const Center(child: EmptyJournalView());
          }
          return SingleChildScrollView(
            padding: AppSpacing.screen,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoodFilter(),
                SizedBox(height: AppSpacing.space20),
                JournalList(),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: const AddMoodFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
