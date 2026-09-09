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
    final selectedImageHeight = (width * 0.78).clamp(260.0, 360.0);

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
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: double.infinity,
            height: image == null ? cardHeight : selectedImageHeight,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: .25),
              ),
            ),
            child: image == null
                ? _buildPlaceholder(context)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: ColoredBox(
                          color: Colors.black,
                          child: Image.file(
                            image!,
                            key: ValueKey(image!.path),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                            gaplessPlayback: true,
                            errorBuilder: (_, __, ___) => _buildPlaceholder(
                              context,
                              title: 'Photo could not be displayed',
                              subtitle: 'Tap to choose another photo.',
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 14,
                        bottom: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: .68),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.photo_camera_back_rounded,
                                color: Colors.white,
                                size: 17,
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Replace photo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildPlaceholder(
    BuildContext context, {
    String title = 'Add a Photo',
    String subtitle =
        "Capture today's memory or\nchoose one from your gallery.",
  }) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final avatarSize = (width * 0.16).clamp(54.0, 68.0);
    final iconSize = (width * 0.07).clamp(26.0, 32.0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: .12),
              ),
              child: Icon(
                LucideIcons.imagePlus,
                size: iconSize,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          ],
        ),
      ),
    );
  }
}
