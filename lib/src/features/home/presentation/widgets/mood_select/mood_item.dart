import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_select_model.dart';

class MoodItem extends StatelessWidget {
  final MoodModel mood;
  final bool selected;
  final VoidCallback onTap;

  const MoodItem({
    super.key,
    required this.mood,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        width: 72,

        padding: const EdgeInsets.symmetric(vertical: 16),

        decoration: BoxDecoration(
          color: Colors.white, // Always white
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? mood.color : const Color(0xFFE9E9E9),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          children: [
            Text(mood.emoji, style: const TextStyle(fontSize: 28)),

            const SizedBox(height: 8),

            Text(
              mood.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? mood.color : const Color(0xFF7B7B7B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
