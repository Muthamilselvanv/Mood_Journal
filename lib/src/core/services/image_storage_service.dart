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

    final extension = path.extension(image.path);

    final fileName =
        'profile_${DateTime.now().millisecondsSinceEpoch}$extension';

    final savedImage = await image.copy(
      path.join(profileDirectory.path, fileName),
    );

    return savedImage.path;
  }
}
