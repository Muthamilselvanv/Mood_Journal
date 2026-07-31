import 'package:flutter/material.dart';
import 'profile_menu_tile.dart';

class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 16),

        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => ProfileMenuTile(
                item: items[index],
                isLast: index == items.length - 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
