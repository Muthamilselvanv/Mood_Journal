import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(context, index: 0, icon: LucideIcons.house, label: "Home"),
            _item(
              context,
              index: 1,
              icon: LucideIcons.bookOpen,
              label: "Journal",
            ),
            _item(
              context,
              index: 2,
              icon: LucideIcons.chartNoAxesCombined,
              label: "Trends",
            ),
            _item(
              context,
              index: 3,
              icon: LucideIcons.userRound,
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? AppColors.primary.withOpacity(.15)
                    : Colors.transparent,
              ),
              child: Icon(
                icon,
                size: 22,
                color: selected
                    ? AppColors.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? AppColors.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
