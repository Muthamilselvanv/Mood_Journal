import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';

class BuildAddMoodButton extends StatelessWidget {
  const BuildAddMoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final repository = Get.find<MoodRepository>();
    return SizedBox(
      width: double.infinity,
      child: AppGradientButton(
        label: "Save",
        icon: Icons.save,
        onPressed: () async {
          final entry = MoodEntry(
            mood: controller.selectedMood.title,
            weather: controller.weather.title,
            activities: controller.selectedActivities.toList(),
            intensity: controller.intensity.value.toInt(),
            title: controller.titleController.text,
            notes: controller.notesController.text,
            createdAt: DateTime.now(),
          );

          try {
            await repository.insertMood(entry);
            controller.resetForm();
            Get.find<JournalController>().loadEntries();
            final entries = await repository.getAllMoods();

            for (final e in entries) {
              if (kDebugMode) {
                print("Submit Data: ${e.id} - ${e.title}");
              }
            }
            Get.find<MainController>().changeTap(1);

            Get.back();
            AppSnackbar.success("Mood saved successfully!");
          } catch (e) {
            AppSnackbar.error("Failed to save mood.");
          }
        },
      ),
    );
  }
}
