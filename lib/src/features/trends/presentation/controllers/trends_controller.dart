import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class TrendsController extends GetxController {
  final controller = Get.find<JournalController>();
  final now = DateTime.now();

  String get favoriteWeather {
    if (controller.moodEntries.isEmpty) return "No data";

    final map = <String, int>{};

    for (final entry in controller.moodEntries) {
      map[entry.weather] = (map[entry.weather] ?? 0) + 1;
    }

    return map.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String get happiestDay {
    if (controller.moodEntries.isEmpty) return "No data";

    final scores = <String, List<int>>{};

    for (final entry in controller.moodEntries) {
      final day = DateFormat('EEEE').format(entry.createdAt);

      scores.putIfAbsent(day, () => []);

      scores[day]!.add(entry.intensity);
    }

    double highest = -1;
    String best = "";

    scores.forEach((day, list) {
      final avg = list.reduce((a, b) => a + b) / list.length;

      if (avg > highest) {
        highest = avg;
        best = day;
      }
    });

    return best;
  }

  String get weekendInsight {
    if (controller.moodEntries.isEmpty) return "No mood data";

    double weekend = 0;
    double weekday = 0;

    int weekendCount = 0;
    int weekdayCount = 0;

    for (final entry in controller.moodEntries) {
      final day = entry.createdAt.weekday;

      if (day == DateTime.saturday || day == DateTime.sunday) {
        weekend += entry.intensity;
        weekendCount++;
      } else {
        weekday += entry.intensity;
        weekdayCount++;
      }
    }

    final weekendAvg = weekendCount == 0 ? 0 : weekend / weekendCount;
    final weekdayAvg = weekdayCount == 0 ? 0 : weekday / weekdayCount;

    if (weekendAvg > weekdayAvg) {
      return "You feel happier on weekends";
    }

    return "Your weekdays are more positive";
  }

  String get favoriteActivity {
    final map = <String, int>{};

    for (final entry in controller.moodEntries) {
      for (final activity in entry.activities) {
        map[activity] = (map[activity] ?? 0) + 1;
      }
    }

    if (map.isEmpty) return "No activity data";

    return map.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  //Weely mood spots for the chart
  List<FlSpot> get weeklyMoodSpots {
    List<FlSpot> spots = [];

    for (int i = 6; i >= 0; i--) {
      final day = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));

      final entries = controller.moodEntries.where((e) {
        final date = DateTime(
          e.createdAt.year,
          e.createdAt.month,
          e.createdAt.day,
        );

        return date == day;
      }).toList();

      double moodScore = 0;

      if (entries.isNotEmpty) {
        moodScore =
            entries.map((e) => e.intensity).reduce((a, b) => a + b) /
            entries.length;
      }

      spots.add(FlSpot((6 - i).toDouble(), moodScore));
    }

    return spots;
  }

  List<String> get last7Days {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final day = now.subtract(Duration(days: 6 - index));
      return DateFormat('EEE').format(day);
    });
  }

  //monthly mood spots for the chart
  List<BarChartGroupData> get monthlyAverageBars {
    final now = DateTime.now();

    final weeks = List.generate(4, (_) => <int>[]);

    for (final mood in controller.moodEntries) {
      if (mood.createdAt.year != now.year ||
          mood.createdAt.month != now.month) {
        continue;
      }

      final day = mood.createdAt.day;

      int weekIndex;

      if (day <= 7) {
        weekIndex = 0;
      } else if (day <= 14) {
        weekIndex = 1;
      } else if (day <= 21) {
        weekIndex = 2;
      } else {
        weekIndex = 3;
      }

      weeks[weekIndex].add(mood.intensity);
    }

    final colors = [
      const Color(0xff34D399),
      const Color(0xff60A5FA),
      const Color(0xffFBBF24),
      const Color(0xff7B61FF),
    ];

    return List.generate(4, (index) {
      double average = 0;

      if (weeks[index].isNotEmpty) {
        average = weeks[index].reduce((a, b) => a + b) / weeks[index].length;
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: average,
            width: 26,
            color: colors[index],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.shade100,
            ),
          ),
        ],

        showingTooltipIndicators: average > 0 ? [0] : [],
      );
    });
  }

  //mood breakdown for the chart
  final Map<String, Color> moodColors = {
    "Happy": const Color(0xffFBBF24),
    "Calm": const Color(0xff34D399),
    "Neutral": const Color(0xff60A5FA),
    "Sad": const Color(0xff8B5CF6),
    "Angry": const Color(0xffFB7185),
  };

  Map<String, int> get moodCounts {
    final Map<String, int> counts = {
      "Happy": 0,
      "Calm": 0,
      "Neutral": 0,
      "Sad": 0,
      "Angry": 0,
    };

    for (final mood in controller.moodEntries) {
      counts[mood.mood] = (counts[mood.mood] ?? 0) + 1;
    }

    return counts;
  }

  List<PieChartSectionData> get moodSections {
    final counts = moodCounts;
    final total = counts.values.fold(0, (a, b) => a + b);

    return counts.entries.where((e) => e.value > 0).map((e) {
      final percent = e.value / total * 100;

      return PieChartSectionData(
        value: e.value.toDouble(),
        color: moodColors[e.key],
        radius: 48,
        title: "${percent.toStringAsFixed(0)}%",
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList();
  }

  String moodPercentage(String mood) {
    final counts = moodCounts;

    final total = counts.values.fold(0, (a, b) => a + b);

    if (total == 0) return "0%";

    final percent = ((counts[mood] ?? 0) / total * 100);

    return "${percent.toStringAsFixed(0)}%";
  }
}
