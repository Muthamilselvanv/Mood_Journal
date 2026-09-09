import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_local_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';

class UserRepository {
  UserRepository({
    UserLocalDataSource? localDataSource,
    UserFirebaseDataSource? firebaseDataSource,
  }) : _localDataSource = localDataSource ?? Get.find(),
       _firebaseDataSource = firebaseDataSource ?? Get.find();

  final UserLocalDataSource _localDataSource;
  final UserFirebaseDataSource _firebaseDataSource;

  UserRepository.fromDataSources(
    this._firebaseDataSource,
    this._localDataSource,
  );

  Future<Map<String, dynamic>?> getUserProfile(String uid) {
    return _firebaseDataSource.getUserProfile(uid);
  }

  /// Register User
  Future<void> register(UserModel user) async {
    final exists = await _localDataSource.emailExists(user.email);

    if (exists) {
      throw Exception("Email already exists");
    }

    await _localDataSource.register(user);
  }

  Future<int> insertUser({
    required String firebaseUid,
    required String name,
    required String email,
    String? profileImage,
    String? bio,
  }) async {
    return await _localDataSource.insertUser(
      firebaseUid: firebaseUid,
      name: name,
      email: email,
      profileImage: profileImage,
      bio: bio,
    );
  }

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firebaseDataSource.createUserProfile(
      uid: uid,
      name: name,
      email: email,
    );
  }

  /// Get user by Firebase UID
  Future<UserModel?> getUserByFirebaseUid(String firebaseUid) async {
    return await _localDataSource.getUserByFirebaseUid(firebaseUid);
  }

  /// Check email
  Future<bool> emailExists(String email) async {
    return await _localDataSource.emailExists(email);
  }

  /// Get User by local ID
  Future<UserModel?> getUser(int id) async {
    return await _localDataSource.getUser(id);
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
