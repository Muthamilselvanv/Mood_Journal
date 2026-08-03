import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class MonthlyAverageChart extends StatelessWidget {
  const MonthlyAverageChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrendsController>();

    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    final chartHeight = isTablet ? 320.0 : 240.0;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("THIS MONTH", style: Theme.of(context).textTheme.labelMedium),

            const SizedBox(height: 4),

            Text(
              "Weekly Averages",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: chartHeight,
              width: double.infinity,
              child: Obx(() {
                final bars = controller.monthlyAverageBars;

                final hasData = bars.any(
                  (group) => group.barRods.any((rod) => rod.toY > 0),
                );

                if (!hasData) {
                  return const Center(
                    child: Text(
                      "No mood entries this month",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return BarChart(
                  BarChartData(
                    maxY: 10,
                    alignment: BarChartAlignment.spaceAround,

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

                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            "${rod.toY.toStringAsFixed(1)}/10",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),

                    barGroups: bars,

                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(),

                      rightTitles: const AxisTitles(),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) {
                              return const SizedBox();
                            }

                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
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
                            const weeks = ["W1", "W2", "W3", "W4"];

                            if (value.toInt() >= weeks.length) {
                              return const SizedBox();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                weeks[value.toInt()],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTablet ? 14 : 11,
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
