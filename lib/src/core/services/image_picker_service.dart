import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickFromGallery({
    double? maxWidth,
    double? maxHeight,
    int imageQuality = 85,
  }) async {
    try {
      if (Platform.isIOS) {
        final status = await Permission.photos.request();
        if (!status.isGranted && !status.isLimited) {
          AppSnackbar.warning(
            status.isPermanentlyDenied
                ? 'Photo access is disabled. Enable it in device Settings.'
                : 'Photo access is needed to choose an image from your library.',
            actionLabel: status.isPermanentlyDenied ? 'Settings' : null,
            onAction: status.isPermanentlyDenied ? openAppSettings : null,
          );
          return null;
        }
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (image == null) {
        return null;
      }

      return File(image.path);
    } catch (_) {
      return null;
    }
  }

  static Future<File?> pickFromCamera({
    double? maxWidth,
    double? maxHeight,
    int imageQuality = 85,
  }) async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        AppSnackbar.warning(
          status.isPermanentlyDenied
              ? 'Camera access is disabled. Enable it in device Settings.'
              : 'Camera access is needed to take a photo.',
          actionLabel: status.isPermanentlyDenied ? 'Settings' : null,
          onAction: status.isPermanentlyDenied ? openAppSettings : null,
        );
        return null;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (image == null) {
        return null;
      }

      final file = File(image.path);

      if (!await file.exists()) {
        return null;
      }

      return file;
    } catch (_) {
      return null;
    }
  }
}
