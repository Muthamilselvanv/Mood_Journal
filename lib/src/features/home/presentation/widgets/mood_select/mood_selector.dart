import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/mood_item.dart';

class MoodSelector extends GetView<HomeController> {
  final String title;
  const MoodSelector({super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppIconSizes.small,
              ),
        ),

        const SizedBox(height: AppSpacing.space12),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              controller.moods.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == controller.moods.length - 1 ? 0 : 8,
                  ),
                  child: MoodItem(
                    mood: controller.moods[index],
                    selected: controller.selectedIndex.value == index,
                    onTap: () => controller.selectMood(index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
