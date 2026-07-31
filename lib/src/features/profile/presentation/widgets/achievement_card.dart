import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class AchievementCard extends StatelessWidget {

  final String emoji;
  final String title;

  const AchievementCard({
    super.key,
    required this.emoji,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 90,
    
      child: Card(
        elevation: 0,
    
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space12),
    
          child: Column(
    
            children: [
    
              Text(
                emoji,
                style: const TextStyle(fontSize: 28),
              ),
    
              const SizedBox(height: 14),
    
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}