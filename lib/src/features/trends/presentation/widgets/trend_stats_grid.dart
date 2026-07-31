import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/features/trends/presentation/widgets/trend_stat_card.dart';

class TrendStatsGrid extends StatelessWidget {
  const TrendStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.15,
      children: const [
        TrendStatCard(
          emoji: "⭐",
          title: "AVG SCORE",
          value: "7.2",
          backgroundColor: Color(0xffFFF8E6),
          borderColor: Color(0xffFFE39A),
        ),

        TrendStatCard(
          emoji: "🔥",
          title: "LONGEST STREAK",
          value: "12 days",
          backgroundColor: Color(0xffFFF2F2),
          borderColor: Color(0xffFFD0D0),
        ),

        TrendStatCard(
          emoji: "📖",
          title: "TOTAL ENTRIES",
          value: "42",
          backgroundColor: Color(0xffEEF5FF),
          borderColor: Color(0xffCFE0FF),
        ),

        TrendStatCard(
          emoji: "😊",
          title: "MOST COMMON",
          value: "Happy",
          backgroundColor: Color(0xffECFFF4),
          borderColor: Color(0xffC8F1D8),
        ),
      ],
    );
  }
}
