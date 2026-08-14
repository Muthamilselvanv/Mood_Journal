import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class WeeklyMoodChart extends StatelessWidget {
  const WeeklyMoodChart({super.key});

  static const purple = Color(0xff7B61FF);

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
            // ----------------------------------------------------------
            // HEADER
            // ----------------------------------------------------------
            Text(
              "THIS WEEK",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Daily Mood Score",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: padding),

            // ----------------------------------------------------------
            // CHART
            // ----------------------------------------------------------
            SizedBox(
              height: chartHeight,
              width: double.infinity,
              child: Obx(() {
                final allSpots = controller.weeklyMoodSpots;

                // Check whether the user has at least one mood entry.
                final hasData = allSpots.any((spot) => spot.y > 0);

                if (!hasData) {
                  final theme = Theme.of(context);

                  return Center(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: purple.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: purple.withOpacity(0.18)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color: purple.withOpacity(0.14),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.insights_rounded,
                              color: purple,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your weekly mood story starts here',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add a mood entry today to begin tracking your daily mood score.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.5,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.65,
                              ),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // ------------------------------------------------------
                // IMPORTANT
                //
                // Do NOT remove the missing day.
                //
                // Keep its X position and replace its Y with
                // FlSpot.nullSpot.
                //
                // This creates a GAP in the line.
                // ------------------------------------------------------

                final List<FlSpot> chartSpots = allSpots.map<FlSpot>((spot) {
                  if (spot.y <= 0) {
                    return FlSpot.nullSpot;
                  }

                  return spot;
                }).toList();

                return LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 6,

                    minY: 0,
                    maxY: 10,

                    clipData: const FlClipData.none(),

                    // --------------------------------------------------
                    // BORDER
                    // --------------------------------------------------
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey.shade200),
                    ),

                    // --------------------------------------------------
                    // GRID
                    // --------------------------------------------------
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

                    // --------------------------------------------------
                    // TOUCH
                    // --------------------------------------------------
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

                    // --------------------------------------------------
                    // LINE
                    // --------------------------------------------------
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartSpots,

                        // Keep straight lines for mood scores.
                        isCurved: false,

                        barWidth: isTablet ? 5 : 4,

                        isStrokeCapRound: true,

                        color: purple,

                        // ------------------------------------------------
                        // AREA BELOW LINE
                        // ------------------------------------------------
                        belowBarData: BarAreaData(
                          show: true,
                          color: purple.withOpacity(0.10),
                        ),

                        // ------------------------------------------------
                        // DOTS
                        // ------------------------------------------------
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 5,
                              color: purple,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                      ),
                    ],

                    // --------------------------------------------------
                    // TITLES
                    // --------------------------------------------------
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),

                      // ------------------------------------------------
                      // LEFT Y AXIS
                      // ------------------------------------------------
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

                      // ------------------------------------------------
                      // X AXIS
                      // ------------------------------------------------
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();

                            if (index < 0 ||
                                index >= controller.last7Days.length) {
                              return const SizedBox();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                controller.last7Days[index],
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
