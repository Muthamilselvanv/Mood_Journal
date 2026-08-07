import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';

class AttachPhotoCard extends StatelessWidget {
  final File? image;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const AttachPhotoCard({super.key, this.image, this.onTap, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final cardHeight = (width * 0.58).clamp(220.0, 320.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ATTACH A PHOTO",
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: AppIconSizes.tiny,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),

        const SizedBox(height: AppSpacing.space8),

        InkWell(
          onTap: image == null ? onTap : null,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: double.infinity,
            height: cardHeight * 1.5,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(.25),
              ),
            ),
            child: image == null
                ? _buildPlaceholder(context)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.file(image!, fit: BoxFit.cover),
                      ),

                      Positioned(
                        top: 14,
                        right: 14,
                        child: Material(
                          color: Colors.black54,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: onRemove,
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final avatarSize = (width * 0.18).clamp(64.0, 82.0);
    final iconSize = (width * 0.08).clamp(28.0, 36.0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(.12),
              ),
              child: Icon(
                LucideIcons.imagePlus,
                size: iconSize,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              "Add a Photo",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Capture today's memory or\nchoose one from your gallery.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    size: 18,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "Camera • Gallery",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),

                const SizedBox(width: 6),

                Text(
                  "Tap anywhere to select",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
