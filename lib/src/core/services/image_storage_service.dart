import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageStorageService {
  ImageStorageService._();

  static Future<String> saveProfileImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();

    final profileDirectory = Directory(
      path.join(directory.path, 'profile_images'),
    );

    if (!await profileDirectory.exists()) {
      await profileDirectory.create(recursive: true);
    }

    final extension = path.extension(image.path).isEmpty
        ? '.jpg'
        : path.extension(image.path);

    final destination = path.join(profileDirectory.path, 'profile$extension');
    if (path.equals(path.absolute(image.path), path.absolute(destination))) {
      return destination;
    }

    final savedImage = await image.copy(destination);

    await for (final entity in profileDirectory.list()) {
      if (entity is File && !path.equals(entity.path, savedImage.path)) {
        await entity.delete();
      }
    }

    return savedImage.path;
  }

  static Future<void> deleteProfileImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final profileDirectory = Directory(
      path.join(directory.path, 'profile_images'),
    );
    if (await profileDirectory.exists()) {
      await profileDirectory.delete(recursive: true);
    }
  }
}
