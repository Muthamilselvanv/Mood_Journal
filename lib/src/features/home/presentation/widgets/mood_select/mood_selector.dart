import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/mood_item.dart';

class MoodSelector extends GetView<HomeController> {
  final String title;
  final RxInt? selection;
  final ValueChanged<int>? onSelected;

  const MoodSelector({
    super.key,
    required this.title,
    this.selection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    //final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.small,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),

        const SizedBox(height: AppSpacing.space12),

        Obx(() {
          // Read synchronously inside Obx. ListView's lazy itemBuilder runs
          // later and cannot register this dependency with GetX by itself.
          final selectedIndex = (selection ?? controller.selectedIndex).value;
          final compact = MediaQuery.sizeOf(context).width < 360;

          return SizedBox(
            height: 106,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.moods.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, index) => MoodItem(
                mood: controller.moods[index],
                selected: selectedIndex == index,
                compact: compact,
                onTap: () {
                  if (onSelected != null) {
                    onSelected!(index);
                  } else {
                    controller.selectMood(index);
                  }
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
