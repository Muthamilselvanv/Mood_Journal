import 'package:flutter/widgets.dart';

class MoodModel {
  final String emoji;
  final String title;
  final String message;
  final Color color;

  const MoodModel({
    required this.emoji,
    required this.title,
    required this.message,
    required this.color,
  });
}
