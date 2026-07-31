import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyMoodChart extends StatelessWidget {
  const WeeklyMoodChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("THIS WEEK", style: Theme.of(context).textTheme.labelMedium),

            const SizedBox(height: 6),

            Text(
              "Daily Mood Score",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 10,

                  gridData: FlGridData(show: true, drawVerticalLine: true),

                  borderData: FlBorderData(show: false),

                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,

                      barWidth: 4,

                      color: const Color(0xff7B61FF),

                      spots: const [
                        FlSpot(0, 6),
                        FlSpot(1, 7),
                        FlSpot(2, 5),
                        FlSpot(3, 3),
                        FlSpot(4, 7),
                        FlSpot(5, 9),
                        FlSpot(6, 8),
                      ],

                      dotData: FlDotData(show: true),
                    ),
                  ],

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),

                    rightTitles: const AxisTitles(),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          const days = [
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat",
                            "Sun",
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(days[value.toInt()]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
