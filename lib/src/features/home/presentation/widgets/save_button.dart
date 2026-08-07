import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';

class BuildAddMoodButton extends StatelessWidget {
  const BuildAddMoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final repository = Get.find<MoodRepository>();
    final userId = GetStorage().read("userId");
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => AppGradientButton(
          text: controller.isEditing ? "Update" : "Save",
          icon: controller.isEditing ? Icons.edit : Icons.save,
          onPressed: () async {
            if (!controller.formKey.currentState!.validate()) return;

            final entry = MoodEntry(
              id: controller.editingEntry.value?.id,
              userId: userId, //controller.userId.value,
              mood: controller.selectedMood.title,
              weather: controller.weather.title,
              activities: controller.selectedActivities.toList(),
              intensity: controller.intensity.value.toInt(),
              title: controller.titleController.text,
              notes: controller.notesController.text,
              createdAt:
                  controller.editingEntry.value?.createdAt ?? DateTime.now(),
              imagePath: controller.selectedImage.value?.path,
              isFavorite: controller.editingEntry.value?.isFavorite ?? false,
            );

            try {
              if (controller.isEditing) {
                await repository.updateMood(entry);

                await controller.loadMood();

                await Get.find<JournalController>().loadEntries();

                controller.resetForm();

                AppSnackbar.success("Mood updated successfully!");

                // Return to JournalDetailPage
                Get.offNamed(AppRoutes.journal);
              } else {
                await repository.insertMood(entry);

                await controller.loadMood();

                await Get.find<JournalController>().loadEntries();

                controller.resetForm();

                Get.find<MainController>().changeTap(1);

                AppSnackbar.success("Mood saved successfully!");

                // Go to Journal tab
                Get.offNamed(AppRoutes.journal);
              }
            } catch (e) {
              AppSnackbar.error(
                controller.isEditing
                    ? "Failed to update mood."
                    : "Failed to save mood.",
              );
            }
          },
        ),
      ),
    );
  }
}
