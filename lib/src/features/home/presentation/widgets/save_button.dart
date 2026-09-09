import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/core/services/network_service.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';

class BuildAddMoodButton extends StatelessWidget {
  const BuildAddMoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final repository = Get.find<MoodRepository>();

    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => AppGradientButton(
          text: controller.isEditing ? "Update" : "Save",

          icon: controller.isEditing ? Icons.edit : Icons.save,

          isLoading: controller.isSaving.value,

          onPressed: () async {
            if (controller.selectedMood == null) {
              AppSnackbar.warning('Please select how you are feeling.');
              return;
            }

            if (!controller.formKey.currentState!.validate()) {
              return;
            }

            controller.isSaving.value = true;

            try {
              final imageFile = controller.selectedImage.value;
              final box = GetStorage();
              final userId = box.read<int>('userId');
              final isGuest = box.read<bool>('isGuest') ?? false;

              if (!isGuest && !await NetworkService.hasInternetConnection()) {
                AppSnackbar.warning(
                  'Internet connection is required to save a signed-in journal.',
                );
                return;
              }

              if (userId == null) {
                throw StateError('No local user session is available.');
              }

              final entry = MoodEntry(
                id: controller.editingEntry.value?.id,
                firebaseId: controller.editingEntry.value?.firebaseId,
                userId: userId,
                mood: controller.selectedMood!.title,
                weather: controller.weather.title,
                activities: controller.selectedActivities.toList(),
                intensity: controller.intensity.value.toInt(),
                title: controller.titleController.text.trim(),
                notes: controller.notesController.text.trim(),
                createdAt:
                    controller.editingEntry.value?.createdAt ?? DateTime.now(),

                // Local device image only
                imageUrl:
                    imageFile?.path ?? controller.editingEntry.value?.imageUrl,
                isFavorite: controller.editingEntry.value?.isFavorite ?? false,
              );

              if (controller.isEditing) {
                if (isGuest) {
                  await repository.updateMood(entry);
                } else {
                  await repository.updateMoodCompletely(entry);
                }

                // 3. Reload UI
                await controller.loadMood();
                await Get.find<JournalController>().loadEntries();

                // 4. Reset
                controller.resetForm();

                // 5. Success
                AppSnackbar.success("Mood updated successfully!");

                Get.offNamed(AppRoutes.journal);
              } else {
                if (isGuest) {
                  await repository.insertMood(entry);
                } else {
                  await repository.addMoodCompletely(entry);
                }

                await controller.loadMood();
                await Get.find<JournalController>().loadEntries();

                controller.resetForm();

                Get.find<MainController>().changeTap(1);

                AppSnackbar.success("Mood saved successfully!");

                Get.offNamed(AppRoutes.journal);
              }
            } on CloudWriteCompletedException {
              controller.resetForm();
              Get.find<MainController>().changeTap(1);
              AppSnackbar.warning(
                'Saved online. Local refresh is pending; do not submit again.',
              );
              Get.offNamed(AppRoutes.journal);
            } catch (_) {
              AppSnackbar.error("Failed to save mood.");
            } finally {
              controller.isSaving.value = false;
            }
          },
        ),
      ),
    );
  }
}
