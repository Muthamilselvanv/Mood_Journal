import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import '../../models/weather_model.dart';

class WeatherItem extends StatelessWidget {
  final WeatherModel weather;
  final bool selected;
  final VoidCallback onTap;

  const WeatherItem({
    super.key,
    required this.weather,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          //color: Colors.white,
          color: selected
              ? weather.color.withValues(alpha: .12)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: selected ? weather.color : Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(weather.emoji),

            const SizedBox(width: AppSpacing.space8),

            Text(
              weather.title,
              style: TextStyle(
                color: selected
                    ? weather.color
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
