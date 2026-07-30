import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class BuildAddMoodButton extends StatelessWidget {
  const BuildAddMoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return SizedBox(
      width: double.infinity,
      child: AppGradientButton(
        label: "Save",
        icon: Icons.save,
        onPressed: () {
          print(controller.selectedMood.title);

          print(controller.weather.title);

          print(controller.selectedActivities);

          print(controller.intensity.value);

          print(controller.titleController.text);

          print(controller.notesController.text);
        },
      ),
    );
  }
}
