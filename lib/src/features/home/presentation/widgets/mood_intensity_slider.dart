import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/constants/app_text_style.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';

class MoodIntensitySlider extends GetView<HomeController> {
  const MoodIntensitySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mood = controller.selectedMood;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MOOD INTENSITY",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppIconSizes.tiny,
              fontFamily: AppTextStyles.heading1.fontFamily,
            ),
          ),

          const SizedBox(height: AppSpacing.space16),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "How strong is this feeling?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppIconSizes.tiny,
                        fontFamily: AppTextStyles.heading1.fontFamily,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "${controller.intensity.value.toInt()}/10",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: mood.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.space12),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6,

                    activeTrackColor: mood.color,

                    inactiveTrackColor: mood.color.withOpacity(.15),

                    thumbColor: mood.color,

                    overlayColor: mood.color.withOpacity(.15),

                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 9,
                    ),

                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 18,
                    ),
                  ),

                  child: Slider(
                    value: controller.intensity.value,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: controller.changeIntensity,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) => Text(
                      "${index + 1}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
