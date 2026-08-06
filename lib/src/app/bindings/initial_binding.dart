import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/auth/data/datasources/user_local_datasource.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';
import 'package:mood_journal_app/src/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:mood_journal_app/src/features/profile/data/repositories/profile_repository.dart';

// Bindings is GetX’s dependency-registration class.
// Get.put creates and registers one AppDatabase.
// permanent: true means GetX keeps it during the whole app session.

// result: anywhere in the app, you can retrieve that same database manager with Get.find<AppDatabase>().

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper.instance, fenix: true);

    Get.lazyPut<UserLocalDataSource>(() => UserLocalDataSource(), fenix: true);

    Get.lazyPut<UserRepository>(
      () => UserRepository(localDataSource: Get.find<UserLocalDataSource>()),
      fenix: true,
    );

    Get.lazyPut<ProfileLocalDataSource>(
      () => ProfileLocalDataSource(),
      fenix: true,
    );

    Get.lazyPut<ProfileRepository>(() => ProfileRepository(), fenix: true);
  }
}
