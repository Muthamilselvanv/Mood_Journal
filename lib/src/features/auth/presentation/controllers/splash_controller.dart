import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';
import 'package:mood_journal_app/src/features/auth/domain/startup_session_decision.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';

class SplashController extends GetxController {
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final seenOnboarding = _box.read<bool>('seenOnboarding') ?? false;
    final isLoggedIn = _box.read<bool>('isLoggedIn') ?? false;
    final isGuest = _box.read<bool>('isGuest') ?? false;
    final localUserId = _box.read<int>('userId');

    final firebaseUser = FirebaseAuth.instance.currentUser;
    final sessionAction = decideStartupSession(
      isLoggedIn: isLoggedIn,
      isGuest: isGuest,
      localUserId: localUserId,
      hasFirebaseUser: firebaseUser != null,
    );

    switch (sessionAction) {
      case StartupSessionAction.openGuestHome:
        Get.offAllNamed(AppRoutes.home);
        return;
      case StartupSessionAction.openSignedOut:
        await _clearSavedSession();
        _openSignedOutRoute(seenOnboarding);
        return;
      case StartupSessionAction.verifyFirebaseSession:
        break;
    }

    try {
      final storedFirebaseUid = _box.read<String>('firebaseUid');

      if (isLoggedIn &&
          !isGuest &&
          storedFirebaseUid == firebaseUser!.uid &&
          localUserId != null) {
        final localUser = await Get.find<UserRepository>().getUser(localUserId);

        if (localUser?.firebaseUid == firebaseUser.uid) {
          Get.offAllNamed(AppRoutes.home);
          return;
        }
      }

      await _restoreSession(firebaseUser!);
      Get.offAllNamed(AppRoutes.home);
    } catch (_) {
      await FirebaseAuth.instance.signOut();
      await _clearSavedSession();
      _openSignedOutRoute(seenOnboarding);

      Get.snackbar(
        'Please sign in again',
        'Your saved session could not be restored.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _restoreSession(User firebaseUser) async {
    final userRepository = Get.find<UserRepository>();
    final profile = await userRepository.getUserProfile(firebaseUser.uid);

    if (profile == null) {
      throw StateError('The Firebase profile is missing.');
    }

    final name = profile['name']?.toString().trim() ?? '';
    final email =
        profile['email']?.toString().trim() ?? firebaseUser.email?.trim() ?? '';
    final profileImage = profile['profileImage']?.toString().trim();
    final bio = profile['bio']?.toString();

    if (name.isEmpty || email.isEmpty) {
      throw StateError('The Firebase profile is incomplete.');
    }

    final localUserId = await userRepository.insertUser(
      firebaseUid: firebaseUser.uid,
      name: name,
      email: email,
      profileImage: profileImage?.isEmpty == true ? null : profileImage,
      bio: bio,
    );

    await Get.find<MoodRepository>().syncMoodEntriesFromFirebase(
      firebaseUid: firebaseUser.uid,
      localUserId: localUserId,
    );

    await _box.write('isLoggedIn', true);
    await _box.write('isGuest', false);
    await _box.write('firebaseUid', firebaseUser.uid);
    await _box.write('userId', localUserId);
    await _box.write('name', name);
    await _box.write('email', email);
  }

  Future<void> _clearSavedSession() async {
    const sessionKeys = <String>[
      'isLoggedIn',
      'isGuest',
      'firebaseUid',
      'userId',
      'name',
      'userName',
      'email',
    ];

    for (final key in sessionKeys) {
      await _box.remove(key);
    }
  }

  void _openSignedOutRoute(bool seenOnboarding) {
    Get.offAllNamed(seenOnboarding ? AppRoutes.login : AppRoutes.onboarding);
  }
}
