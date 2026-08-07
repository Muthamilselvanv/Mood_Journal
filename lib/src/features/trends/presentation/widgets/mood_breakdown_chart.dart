import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class MoodBreakdownChart extends StatelessWidget {
  const MoodBreakdownChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrendsController>();

    final width = MediaQuery.of(context).size.width;
    final chartSize = width < 400 ? 150.0 : 180.0;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DISTRIBUTION",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,),
            ),

            const SizedBox(height: 4),

            Text(
              "Mood Breakdown",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,),
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: chartSize,
                    child: Obx(() {
                      if (controller.moodSections.isEmpty) {
                        return const Center(child: Text("No mood data"));
                      }

                      return PieChart(
                        PieChartData(
                          centerSpaceRadius: chartSize * .22,
                          sectionsSpace: 4,
                          sections: controller.moodSections,
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.moodColors.entries.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _LegendItem(
                            color: item.value,
                            title: item.key,
                            percent: controller.moodPercentage(item.key),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final String percent;

  const _LegendItem({
    required this.color,
    required this.title,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500,fontFamily: GoogleFonts.poppins().fontFamily,),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(.12),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            percent,
            style: TextStyle(color: color, fontWeight: FontWeight.bold,fontFamily: GoogleFonts.poppins().fontFamily,),
          ),
        ),
      ],
    );
  }
}
