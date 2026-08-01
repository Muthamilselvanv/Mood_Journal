import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  static Future<bool> requestGalleryPermission() async {
    PermissionStatus status;

    if (await Permission.photos.isGranted) {
      return true;
    }

    status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    }

    final storage = await Permission.storage.request();

    if (storage.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied || storage.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }
}
