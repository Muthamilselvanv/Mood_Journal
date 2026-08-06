import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/profile/data/datasource/profile_local_datasource.dart';

class ProfileRepository {
  final ProfileLocalDataSource _localDataSource =
      Get.find<ProfileLocalDataSource>();

  Future<UserModel?> getUser(int userId) {
    return _localDataSource.getUser(userId);
  }

  Future<void> updateProfile(UserModel user) {
    return _localDataSource.updateProfile(user);
  }
}
