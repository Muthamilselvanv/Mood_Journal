import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/constants/app_text_style.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';

class InputFields extends StatelessWidget {
  const InputFields({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Form(
      key: controller.formKey,
      child: Column(
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
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter a journal title";
              }

              if (value.trim().length < 3) {
                return "Title must be at least 3 characters";
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: "Give your day a title...",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please write something about your day";
              }

              if (value.trim().length < 10) {
                return "Please write at least 10 characters";
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: "Write about your day...",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
