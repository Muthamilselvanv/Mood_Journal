import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/add_mood_fab.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_list.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/mood_filter.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

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
          "Journal",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        actions: [
          IconButton(
            onPressed: () {
              // Later:
              // Open Search Delegate
            },
            icon: Icon(
              Icons.search_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
               const MoodFilter(),
               const SizedBox(height: AppSpacing.space20),
               const JournalList()
            ],
          ),
        ),
      ),
      floatingActionButton: const AddMoodFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
