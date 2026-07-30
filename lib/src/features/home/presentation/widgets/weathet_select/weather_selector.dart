import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/constants/app_text_style.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/mood_select_controller.dart';
import 'weather_item.dart';

class WeatherSelector extends GetView<HomeController> {
  const WeatherSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "WEATHER",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: AppTextStyles.heading1.fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 12,
            children: List.generate(controller.weathers.length, (index) {
              return WeatherItem(
                weather: controller.weathers[index],
                selected: controller.selectedWeather.value == index,
                onTap: () => controller.changeWeather(index),
              );
            }),
          ),
        ),
      ],
    );
  }
}
