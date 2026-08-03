import 'package:flutter/material.dart';

class InsightTile extends StatelessWidget {
  final String emoji;
  final Widget title;

  const InsightTile({super.key, required this.emoji, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),

          const SizedBox(width: 12),

          Expanded(child: title),
        ],
      ),
    );
  }
}
