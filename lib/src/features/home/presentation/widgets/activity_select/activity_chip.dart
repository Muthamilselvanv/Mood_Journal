import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/activity_model.dart';

class ActivityChip extends StatelessWidget {
  final ActivityModel activity;
  final bool selected;
  final VoidCallback onTap;

  const ActivityChip({
    super.key,
    required this.activity,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? activity.color.withValues(alpha: .12)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? activity.color : Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              activity.icon,
              size: 18,
              color: selected ? activity.color : Colors.grey,
            ),

            const SizedBox(width: 8),

            Text(
              activity.title,
              style: TextStyle(
                color: selected
                    ? activity.color
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
