import 'package:flutter/material.dart';

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

class ProfileMenuTile extends StatelessWidget {
  final ProfileMenuItem item;
  final bool isLast;

  const ProfileMenuTile({super.key, required this.item, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F1FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: theme.colorScheme.primary),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: theme.textTheme.titleMedium),

                      const SizedBox(height: 4),

                      Text(
                        item.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),

            if (!isLast)
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Divider(height: 1),
              ),
          ],
        ),
      ),
    );
  }
}
