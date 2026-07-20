import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

class MoodPalette {
  const MoodPalette._({required this.emoji, required this.color, required this.lightBackground});

  final String emoji;
  final Color color;
  final Color lightBackground;

  static const happy = MoodPalette._(
    emoji: '😊',
    color: AppColors.warmYellow,
    lightBackground: Color(0xFFFFFBEB),
  );
  static const calm = MoodPalette._(
    emoji: '😌',
    color: AppColors.mintGreen,
    lightBackground: Color(0xFFECFDF5),
  );
  static const neutral = MoodPalette._(
    emoji: '😐',
    color: AppColors.skyBlue,
    lightBackground: Color(0xFFEFF6FF),
  );
  static const sad = MoodPalette._(
    emoji: '😔',
    color: AppColors.primary,
    lightBackground: Color(0xFFF5F3FF),
  );
  static const angry = MoodPalette._(
    emoji: '😡',
    color: AppColors.coralRose,
    lightBackground: Color(0xFFFFF1F2),
  );

  static MoodPalette fromMood(String mood) => switch (mood.toLowerCase()) {
        'happy' => happy,
        'calm' => calm,
        'neutral' => neutral,
        'sad' => sad,
        'angry' => angry,
        _ => neutral,
      };
}
