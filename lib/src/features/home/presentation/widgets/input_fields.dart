import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/constants/app_text_style.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';

class InputFields extends StatelessWidget {
  const InputFields({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "JOURNAL TITLE",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: AppTextStyles.heading1.fontFamily,
          ),
        ),

        const SizedBox(height: AppSpacing.space4),
        TextFormField(
          controller: controller.titleController,
          decoration: InputDecoration(
            hintText: "Give your day a title...",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        Text(
          "NOTES",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: AppTextStyles.heading1.fontFamily,
          ),
        ),

        const SizedBox(height: AppSpacing.space4),
        TextFormField(
          controller: controller.notesController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: "Write about your day...",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
