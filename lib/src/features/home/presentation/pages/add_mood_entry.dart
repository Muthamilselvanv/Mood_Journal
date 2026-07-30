import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/activity_select/activity_selector.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/input_fields.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_intensity_slider.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/mood_selector.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/selected_mood_card.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/datecard.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/save_button.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/weathet_select/weather_selector.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class AddMoodEntry extends StatefulWidget {
  const AddMoodEntry({super.key});

  @override
  State<AddMoodEntry> createState() => _AddMoodEntryState();
}

class _AddMoodEntryState extends State<AddMoodEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: AppSpacing.space20,
        toolbarHeight: AppSpacing.toolBarhight, // 70
        // backgroundColor: AppColors.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Add Mood Entry',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            children: [
              const SelectedMoodCard(),
              const SizedBox(height: AppSpacing.space20),
              const MoodSelector(title: "How are you feeling?"),
              const SizedBox(height: AppSpacing.space20),
              const Datecard(),
              const SizedBox(height: AppSpacing.space20),
              const MoodIntensitySlider(),
              const SizedBox(height: AppSpacing.space20),
              const WeatherSelector(),
              const SizedBox(height: AppSpacing.space20),
              const ActivitySelector(),
              const SizedBox(height: AppSpacing.space20),
              const InputFields(),
              const SizedBox(height: AppSpacing.space20),
              const BuildAddMoodButton(),
              //const SizedBox(height: AppSpacing.space20),
            ],
          ),
        ),
      ),
    );
  }
}

