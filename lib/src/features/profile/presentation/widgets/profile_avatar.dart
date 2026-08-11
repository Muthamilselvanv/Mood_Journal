import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.imagePath, required this.onTap});

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imagePath != null &&
        imagePath!.trim().isNotEmpty &&
        File(imagePath!).existsSync();

    debugPrint("Avatar imagePath: $imagePath");
    debugPrint("Avatar hasImage: $hasImage");

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xff7C4DFF), Color(0xff5AA9FF)],
            ),
          ),
          child: CircleAvatar(
            radius: 54,
            backgroundColor: const Color(0xffEEF2FF),
            backgroundImage: hasImage ? FileImage(File(imagePath!)) : null,
            child: !hasImage
                ? Image.asset(
                    AppAssets.niloraIcon,
                    width: 58,
                    fit: BoxFit.contain,
                    color: const Color(0xff7C4DFF),
                  )
                : null,
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xff7C4DFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
