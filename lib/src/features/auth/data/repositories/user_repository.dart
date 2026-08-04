import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_local_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';

class UserRepository {
  UserRepository({UserLocalDataSource? localDataSource})
      : _localDataSource =
            localDataSource ?? Get.find<UserLocalDataSource>();

  final UserLocalDataSource _localDataSource;

  /// Register User
  Future<void> register(UserModel user) async {
    final exists = await _localDataSource.usernameExists(user.username);

    if (exists) {
      throw Exception("username already exists");
    }

    await _localDataSource.register(user);
  }

  /// Login User
  Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    return await _localDataSource.login(username: username, password: password);
  }

  /// Check username
  Future<bool> usernameExists(String username) {
    return _localDataSource.usernameExists(username);
  }

  /// Get User
  Future<UserModel?> getUser(int id) {
    return _localDataSource.getUser(id);
  }

  /// Update Profile
  Future<void> updateUser(UserModel user) async {
    await _localDataSource.updateUser(user);
  }

  /// Delete Account
  Future<void> deleteUser(int id) async {
    await _localDataSource.deleteUser(id);
  }
}
