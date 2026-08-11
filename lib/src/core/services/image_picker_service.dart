import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickFromGallery() async {
    try {
      debugPrint("📸 Opening gallery...");

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) {
        debugPrint("❌ No image selected");
        return null;
      }

      debugPrint("✅ Image path: ${image.path}");

      return File(image.path);
    } catch (e, stackTrace) {
      debugPrint("❌ Image picker error: $e");
      debugPrint("$stackTrace");
      return null;
    }
  }

  static Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return null;
      }

      final file = File(image.path);

      if (!await file.exists()) {
        return null;
      }

      return file;
    } catch (e, stackTrace) {
      debugPrint("❌ Camera error: $e");
      debugPrint("$stackTrace");
      return null;
    }
  }
}
