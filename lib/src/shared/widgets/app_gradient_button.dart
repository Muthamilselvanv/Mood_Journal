import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_design_tokens.dart';

/// Use for the design system's prominent primary actions.
class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isEnabled ? AppGradients.primary : null,
        color: isEnabled ? null : Theme.of(context).disabledColor,
        borderRadius: AppRadii.medium,
        boxShadow: isEnabled ? AppShadows.primary : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadii.medium,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
