import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';

class MoodIntensitySlider extends GetView<HomeController> {
  const MoodIntensitySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mood = controller.selectedMood;
      final accentColor = mood?.color ?? Theme.of(context).colorScheme.primary;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MOOD INTENSITY",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppIconSizes.tiny,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),

          const SizedBox(height: AppSpacing.space8),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "How strong is this feeling?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: AppIconSizes.tiny,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "${controller.intensity.value.toInt()}/10",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.space8),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6,

                    activeTrackColor: accentColor,

                    inactiveTrackColor: accentColor.withValues(alpha: .15),

                    thumbColor: accentColor,

                    overlayColor: accentColor.withValues(alpha: .15),

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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
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
