import 'package:flutter/material.dart';

class WeatherModel {
  final String emoji;
  final String title;
  final Color color;

  const WeatherModel({
    required this.emoji,
    required this.title,
    required this.color
  });
}