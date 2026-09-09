import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';

class RegisterController extends GetxController {
  final UserRepository _repository = Get.find<UserRepository>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final isLoading = false.obs;

  void togglePassword() => obscurePassword.toggle();
  void toggleConfirmPassword() => obscureConfirmPassword.toggle();

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() => nameError.value = null);
    emailController.addListener(() => emailError.value = null);
    passwordController.addListener(() => passwordError.value = null);
    confirmPasswordController.addListener(
      () => confirmPasswordError.value = null,
    );
  }

  Future<void> register() async {
    nameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    var valid = true;

    if (name.isEmpty) {
      nameError.value = 'Please enter your name';
      valid = false;
    }

    if (email.isEmpty) {
      emailError.value = 'Email is required';
      valid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email';
      valid = false;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Minimum 6 characters';
      valid = false;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Confirm your password';
      valid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      valid = false;
    }

    if (!valid) return;

    isLoading.value = true;
    User? createdUser;
    var profileCreated = false;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw StateError('Firebase did not return a created user.');
      }
      createdUser = firebaseUser;

      await _repository.createUserProfile(
        uid: firebaseUser.uid,
        name: name,
        email: email,
      );
      profileCreated = true;

      // Firebase automatically signs in after account creation.
      // Sign out so the user must log in manually.
      await FirebaseAuth.instance.signOut();

      // SQLite is restored from Firestore after the user's first login.
      await _clearSavedSession();

      _openLogin();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Account created',
          'Please log in with your new email and password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      });
    } on FirebaseAuthException catch (error) {
      if (profileCreated) {
        await FirebaseAuth.instance.signOut();
        await _clearSavedSession();
        _openLogin();

        Get.snackbar(
          'Account created',
          'Please log in with your new email and password.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (createdUser != null && !profileCreated) {
        await _rollbackCreatedAccount(createdUser);
      }

      if (error.code == 'email-already-in-use') {
        emailError.value = 'This email is already registered';
      } else if (error.code == 'invalid-email') {
        emailError.value = 'Enter a valid email';
      } else if (error.code == 'weak-password') {
        passwordError.value = 'Password is too weak';
      } else {
        Get.snackbar('Registration failed', error.message ?? 'Try again.');
      }
    } on FirebaseException catch (_) {
      final rolledBack = await _rollbackCreatedAccount(createdUser);

      Get.snackbar(
        'Profile setup failed',
        rolledBack
            ? 'No account was kept. Check your connection and try again.'
            : 'Your account may have been created. Try signing in or resetting '
                  'your password before registering again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      if (profileCreated) {
        await FirebaseAuth.instance.signOut();
        await _clearSavedSession();
        _openLogin();

        Get.snackbar(
          'Account created',
          'Please log in with your new email and password.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final rolledBack = await _rollbackCreatedAccount(createdUser);

      Get.snackbar(
        'Registration failed',
        rolledBack
            ? 'No account was kept. Please try again.'
            : 'Your account may have been created. Try signing in or resetting '
                  'your password before registering again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _clearSavedSession() async {
    final box = GetStorage();
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
      await box.remove(key);
    }
  }

  void _openLogin() {
    if (Get.previousRoute == AppRoutes.login) {
      Get.back();
      return;
    }

    Get.offAllNamed(AppRoutes.login);
  }

  Future<bool> _rollbackCreatedAccount(User? user) async {
    if (user == null) return false;

    var deleted = false;

    try {
      await user.delete();
      deleted = true;
    } catch (_) {
    } finally {
      try {
        await FirebaseAuth.instance.signOut();
        await _clearSavedSession();
      } catch (_) {}
    }

    return deleted;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
