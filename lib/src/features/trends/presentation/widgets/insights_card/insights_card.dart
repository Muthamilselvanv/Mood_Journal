import 'package:flutter/material.dart';
import 'insight_tile.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xffEEF2FF), Color(0xffE0F2FE), Color(0xffDCFCE7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xffC4B5FD),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "✨ INSIGHTS",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xff7C4DFF),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Your Mood Patterns",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              const InsightTile(
                emoji: "🌞",
                title: "You feel happiest on weekends",
              ),

              SizedBox(height: 14),

              InsightTile(
                emoji: "💪",
                title: "Your mood improves after exercise",
              ),

              SizedBox(height: 14),

              InsightTile(
                emoji: "🌙",
                title: "Evening entries tend to be calmer",
              ),

              SizedBox(height: 14),

              InsightTile(
                emoji: "☀️",
                title: "Sunny days boost your score by +1.8",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
