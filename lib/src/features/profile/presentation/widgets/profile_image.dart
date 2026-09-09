import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imagePath,
    required this.size,
    this.iconColor,
  });

  final String? imagePath;
  final double size;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final value = imagePath?.trim() ?? '';

    return ClipOval(
      child: SizedBox.square(dimension: size, child: _buildImage(value)),
    );
  }

  Widget _buildImage(String value) {
    if (value.startsWith('data:image/')) {
      try {
        final encoded = value.substring(value.indexOf(',') + 1);
        return Image.memory(
          base64Decode(encoded),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(),
        );
      } on FormatException {
        return _fallback();
      }
    }

    if (value.startsWith('https://') || value.startsWith('http://')) {
      return Image.network(
        value,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : Container(
                color: const Color(0xffEEF2FF),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
      );
    }

    if (value.isNotEmpty && File(value).existsSync()) {
      return Image.file(
        File(value),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    return _fallback();
  }

  Widget _fallback() {
    return ColoredBox(
      color: const Color(0xffEEF2FF),
      child: Padding(
        padding: EdgeInsets.all(size * 0.22),
        child: Image.asset(
          AppAssets.niloraIcon,
          fit: BoxFit.contain,
          color: iconColor ?? const Color(0xff7C4DFF),
        ),
      ),
    );
  }
}
