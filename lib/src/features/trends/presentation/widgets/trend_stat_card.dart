import 'package:flutter/material.dart';

class TrendStatCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String value;
  final Color backgroundColor;
  final Color borderColor;

  const TrendStatCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),

          const SizedBox(height: 12),

          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
