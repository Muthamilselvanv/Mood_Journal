import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class WeeklyMoodChart extends StatelessWidget {
  const WeeklyMoodChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrendsController>();

    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    final chartHeight = isTablet ? 320.0 : size.height * 0.28;
    final padding = isTablet ? 24.0 : 16.0;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("THIS WEEK", style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,)),

            const SizedBox(height: 6),

            Text(
              "Daily Mood Score",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily,),
            ),

            SizedBox(height: padding),

            SizedBox(
              height: chartHeight,
              width: double.infinity,
              child: Obx(() {
                if (controller.weeklyMoodSpots.every((e) => e.y == 0)) {
                  return Center(
                    child: Text(
                      "No mood entries this week",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  );
                }

                return LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 10,

                    clipData: const FlClipData.all(),

                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey.shade200),
                    ),

                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 2,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.shade200,
                          strokeWidth: 1,
                        );
                      },
                    ),

                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (spots) {
                          return spots.map((spot) {
                            return LineTooltipItem(
                              "${spot.y.toStringAsFixed(1)}/10",
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),

                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.weeklyMoodSpots,

                        isCurved: true,
                        curveSmoothness: 0.35,

                        barWidth: isTablet ? 5 : 4,

                        isStrokeCapRound: true,

                        color: const Color(0xff7B61FF),

                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xff7B61FF).withOpacity(.12),
                        ),

                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            final isLast =
                                index == controller.weeklyMoodSpots.length - 1;

                            return FlDotCirclePainter(
                              radius: isLast ? 6 : 4,
                              color: const Color(0xff7B61FF),
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                      ),
                    ],

                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 2,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) {
                              return const SizedBox();
                            }

                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            );
                          },
                        ),
                      ),

                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                          getTitlesWidget: (value, meta) {
                            if (value < 0 ||
                                value >= controller.last7Days.length) {
                              return const SizedBox();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                controller.last7Days[value.toInt()],
                                style: TextStyle(
                                  fontSize: isTablet ? 13 : 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
