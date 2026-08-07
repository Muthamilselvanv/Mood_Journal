import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/activity_select/activity_chip.dart';

class ActivitySelector extends GetView<HomeController> {
  const ActivitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ACTIVITIES",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Obx(
          () => Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.activities.map((activity) {
              return ActivityChip(
                activity: activity,
                selected: controller.isActivitySelected(activity.title),
                onTap: () => controller.toggleActivity(activity.title),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
