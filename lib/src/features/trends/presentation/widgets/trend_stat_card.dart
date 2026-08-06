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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 125,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? borderColor.withOpacity(.18) : backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? borderColor.withOpacity(.50) : borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),

          const SizedBox(height: 12),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
