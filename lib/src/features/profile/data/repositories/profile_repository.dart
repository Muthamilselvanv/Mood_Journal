import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/profile/data/datasource/profile_local_datasource.dart';

class ProfileRepository {
  ProfileRepository({
    ProfileLocalDataSource? localDataSource,
    UserFirebaseDataSource? firebaseDataSource,
  }) : _localDataSource = localDataSource ?? Get.find(),
       _firebaseDataSource = firebaseDataSource ?? Get.find();

  final ProfileLocalDataSource _localDataSource;
  final UserFirebaseDataSource _firebaseDataSource;

  Future<UserModel?> getUser(int userId) {
    return _localDataSource.getUser(userId);
  }

  Future<UserModel> updateProfile(UserModel user) async {
    var profileImage = user.profileImage;
    final isRemoteImage =
        profileImage?.startsWith('http://') == true ||
        profileImage?.startsWith('https://') == true ||
        profileImage?.startsWith('data:image/') == true;

    if (profileImage != null && profileImage.isNotEmpty && !isRemoteImage) {
      final imageFile = File(profileImage);
      if (!imageFile.existsSync()) {
        throw StateError('The selected profile image is no longer available.');
      }

      final bytes = await imageFile.readAsBytes();
      if (bytes.length > 700 * 1024) {
        throw StateError('The selected profile image is too large.');
      }

      profileImage = 'data:image/jpeg;base64,${base64Encode(bytes)}';
    }

    final persistedUser = user.copyWith(profileImage: profileImage);

    // Firestore is the long-term profile source.
    await _firebaseDataSource.updateUserProfile(
      uid: user.firebaseUid,
      name: user.name,
      bio: user.bio ?? '',
      profileImage: profileImage,
    );

    // Keep the local cache/UI current.
    await _localDataSource.updateProfile(persistedUser);
    return persistedUser;
  }
}
