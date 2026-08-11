import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService._();

  static final FirebaseStorageService instance = FirebaseStorageService._();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadMoodImage(File imageFile) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final reference = _storage
        .ref()
        .child('users')
        .child(user.uid)
        .child('mood_images')
        .child(fileName);

    await reference.putFile(imageFile);

    return await reference.getDownloadURL();
  }
}
