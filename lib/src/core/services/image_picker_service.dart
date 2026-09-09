import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
      final status = await _requestGalleryPermission();
      if (!status.isGranted && !status.isLimited) {
        AppSnackbar.warning(
          status.isPermanentlyDenied
              ? 'Gallery access is disabled. Enable Photos and videos in device Settings.'
              : 'Photo access is needed to choose an image from your gallery.',
          actionLabel: status.isPermanentlyDenied ? 'Settings' : null,
          onAction: status.isPermanentlyDenied ? openAppSettings : null,
        );
        return null;
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

  static Future<PermissionStatus> _requestGalleryPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33
          ? Permission.photos.request()
          : Permission.storage.request();
    }

    return Permission.photos.request();
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
