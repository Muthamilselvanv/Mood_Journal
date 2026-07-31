import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodBreakdownChart extends StatelessWidget {
  const MoodBreakdownChart({super.key});

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
            Text(
              "DISTRIBUTION",
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(height: 4),

            Text(
              "Mood Breakdown",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 38,
                        sectionsSpace: 4,

                        sections: [
                          PieChartSectionData(
                            value: 35,
                            color: const Color(0xffFBBF24),
                            showTitle: false,
                            radius: 42,
                          ),

                          PieChartSectionData(
                            value: 28,
                            color: const Color(0xff34D399),
                            showTitle: false,
                            radius: 42,
                          ),

                          PieChartSectionData(
                            value: 20,
                            color: const Color(0xff60A5FA),
                            showTitle: false,
                            radius: 42,
                          ),

                          PieChartSectionData(
                            value: 12,
                            color: const Color(0xff8B5CF6),
                            showTitle: false,
                            radius: 42,
                          ),

                          PieChartSectionData(
                            value: 5,
                            color: const Color(0xffFB7185),
                            showTitle: false,
                            radius: 42,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 24),

                const Expanded(
                  child: Column(
                    children: [
                      _LegendItem(
                        color: Color(0xffFBBF24),
                        title: "Happy",
                        percent: "35%",
                      ),

                      SizedBox(height: 16),

                      _LegendItem(
                        color: Color(0xff34D399),
                        title: "Calm",
                        percent: "28%",
                      ),

                      SizedBox(height: 16),

                      _LegendItem(
                        color: Color(0xff60A5FA),
                        title: "Neutral",
                        percent: "20%",
                      ),

                      SizedBox(height: 16),

                      _LegendItem(
                        color: Color(0xff8B5CF6),
                        title: "Sad",
                        percent: "12%",
                      ),

                      SizedBox(height: 16),

                      _LegendItem(
                        color: Color(0xffFB7185),
                        title: "Angry",
                        percent: "5%",
                      ),
                    ],
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
        CircleAvatar(radius: 8, backgroundColor: color),

        const SizedBox(width: 12),

        Expanded(child: Text(title)),

        Text(percent, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
