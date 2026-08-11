import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_local_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';
import 'package:mood_journal_app/src/features/home/data/datasources/mood_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:mood_journal_app/src/features/profile/data/repositories/profile_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper.instance, fenix: true);

    Get.lazyPut<UserLocalDataSource>(() => UserLocalDataSource(), fenix: true);

    Get.lazyPut<UserFirebaseDataSource>(
      () => UserFirebaseDataSource(),
      fenix: true,
    );

    Get.lazyPut<UserRepository>(
      () => UserRepository(
        localDataSource: Get.find<UserLocalDataSource>(),
        firebaseDataSource: Get.find<UserFirebaseDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ProfileLocalDataSource>(
      () => ProfileLocalDataSource(),
      fenix: true,
    );

    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);

    Get.lazyPut<MoodFirebaseDataSource>(
      () => MoodFirebaseDataSource(),
      fenix: true,
    );

    Get.lazyPut<MoodRepository>(
      () => MoodRepository(Get.find<MoodFirebaseDataSource>()),
      fenix: true,
    );
  }
}
