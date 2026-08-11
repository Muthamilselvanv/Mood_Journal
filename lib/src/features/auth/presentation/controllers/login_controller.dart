import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailError = RxnString();
  final passwordError = RxnString();
  final obscurePassword = true.obs;
  final isLoading = false.obs;

  final UserRepository repository = Get.find<UserRepository>();
  final MoodRepository moodRepository = Get.find<MoodRepository>();

  void togglePassword() => obscurePassword.toggle();

  Future<void> login() async {
    emailError.value = null;
    passwordError.value = null;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) emailError.value = 'Email is required';
    if (password.isEmpty) passwordError.value = 'Password is required';
    if (emailError.value != null || passwordError.value != null) return;

    isLoading.value = true;

    try {
      // 1. Firebase Authentication
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw StateError('Firebase sign-in returned no user.');
      }

      // 2. Permanent Firestore profile. SQLite is deliberately not used here.
      debugPrint('Loading Firestore profile for ${firebaseUser.uid}');
      final profile = await repository.getUserProfile(firebaseUser.uid);

      if (profile == null) {
        passwordError.value =
            'Your account profile is missing. Please contact support.';
        return;
      }

      final name = profile['name']?.toString().trim() ?? '';
      final userEmail =
          profile['email']?.toString().trim() ??
          firebaseUser.email?.trim() ??
          '';

      if (name.isEmpty || userEmail.isEmpty) {
        throw StateError('Firestore profile is incomplete.');
      }

      // 3. Recreate SQLite user after reinstall, or use its existing local ID.
      final localUser = await repository.getUserByFirebaseUid(firebaseUser.uid);

      final localUserId =
          localUser?.id ??
          await repository.insertUser(
            firebaseUid: firebaseUser.uid,
            name: name,
            email: userEmail,
          );

      // 4. Firestore → SQLite journal upsert.
      await moodRepository.syncMoodEntriesFromFirebase(
        firebaseUid: firebaseUser.uid,
        localUserId: localUserId,
      );

      // 5. Persist session only after complete restoration succeeds.
      final box = GetStorage();
      await box.write('isLoggedIn', true);
      await box.write('isGuest', false);
      await box.write('firebaseUid', firebaseUser.uid);
      await box.write('userId', localUserId);
      await box.write('name', name);
      await box.write('email', userEmail);

      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (error, stackTrace) {
      debugPrint('LOGIN AUTH ERROR: ${error.code} ${error.message}');
      debugPrintStack(stackTrace: stackTrace);

      switch (error.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          passwordError.value = 'Invalid email or password';
          break;
        case 'invalid-email':
          emailError.value = 'Invalid email address';
          break;
        case 'user-disabled':
          emailError.value = 'This account has been disabled';
          break;
        case 'too-many-requests':
          passwordError.value = 'Too many attempts. Try again later.';
          break;
        default:
          passwordError.value = error.message ?? 'Unable to sign in';
      }
    } on FirebaseException catch (error, stackTrace) {
      debugPrint('LOGIN FIRESTORE ERROR: ${error.code} ${error.message}');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Cloud data error',
        'Sign-in succeeded, but your profile or journals could not be loaded. '
            'Check your connection and Firestore rules.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on StateError catch (error, stackTrace) {
      debugPrint('LOGIN DATA ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Account setup error',
        error.message?.toString() ?? 'Your account data is incomplete.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error, stackTrace) {
      debugPrint('LOGIN ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Login failed',
        'Something went wrong while restoring your local data.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.trim().isEmpty) {
      Get.snackbar(
        'Email required',
        'Please enter your email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      Get.back();
      Get.snackbar(
        'Email sent',
        'Check your email for the password-reset link.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Unable to reset password',
        error.message ?? 'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void popUp() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: const Color(0xffF3EEFF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  size: 38,
                  color: Color(0xff7C4DFF),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "Nilora works completely offline.\n"
                "Password recovery isn't available because your account is stored only on this device.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontSize: 15,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7C4DFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    "Create New Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff7C4DFF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: const Color(0xff7C4DFF),
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
