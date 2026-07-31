import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/core/constants/app_text_style.dart';

class AttachPhotoCard extends StatelessWidget {
  final VoidCallback? onTap;

  const AttachPhotoCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ATTACH A PHOTO",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppIconSizes.tiny,
            fontFamily: AppTextStyles.heading1.fontFamily,
          ),
        ),

        const SizedBox(height: AppSpacing.space4),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(.4),
                width: 1.3,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(.12),
                  child: Icon(
                    LucideIcons.imagePlus,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "Attach a Photo",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 6),

                Text(
                  "Capture a memory from today",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "JPG • PNG • Camera • Gallery",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
