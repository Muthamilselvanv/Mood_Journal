import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyAverageChart extends StatelessWidget {
  const MonthlyAverageChart({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: 230,
              child: BarChart(
                BarChartData(
                  maxY: 10,

                  borderData: FlBorderData(show: false),

                  gridData: FlGridData(drawVerticalLine: false),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),

                    rightTitles: const AxisTitles(),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const weeks = [
                            "Week 1",
                            "Week 2",
                            "Week 3",
                            "Week 4",
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              weeks[value.toInt()],
                              style: const TextStyle(color: Color(0xffA78BFA)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 6.5,
                          color: const Color(0xff34D399),
                          width: 36,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),

                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 7,
                          color: const Color(0xff34D399),
                          width: 36,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),

                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 5.8,
                          color: const Color(0xff60A5FA),
                          width: 36,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),

                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 7.8,
                          color: const Color(0xffFBBF24),
                          width: 36,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
