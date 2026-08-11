import 'package:cloud_firestore/cloud_firestore.dart';
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

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw StateError('Firebase did not return a created user.');
      }

      debugPrint('Creating Firestore profile for ${firebaseUser.uid}');
      await _repository.createUserProfile(
        uid: firebaseUser.uid,
        name: name,
        email: email,
      );

      final localUserId = await _repository.insertUser(
        firebaseUid: firebaseUser.uid,
        name: name,
        email: email,
      );

      final box = GetStorage();
      await box.write('isLoggedIn', true);
      await box.write('isGuest', false);
      await box.write('firebaseUid', firebaseUser.uid);
      await box.write('userId', localUserId);
      await box.write('name', name);
      await box.write('email', email);

      Get.snackbar(
        'Account created',
        'Please log in with your new email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed(AppRoutes.login);
    } on FirebaseAuthException catch (error, stackTrace) {
      debugPrint('REGISTER AUTH ERROR: ${error.code} ${error.message}');
      debugPrintStack(stackTrace: stackTrace);

      if (error.code == 'email-already-in-use') {
        emailError.value = 'This email is already registered';
      } else if (error.code == 'invalid-email') {
        emailError.value = 'Enter a valid email';
      } else if (error.code == 'weak-password') {
        passwordError.value = 'Password is too weak';
      } else {
        Get.snackbar('Registration failed', error.message ?? 'Try again.');
      }
    } on FirebaseException catch (error, stackTrace) {
      debugPrint('REGISTER FIRESTORE ERROR: ${error.code} ${error.message}');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Profile setup failed',
        'Your account was created, but the Firestore profile could not be saved. '
            'Check your connection and Firestore rules.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error, stackTrace) {
      debugPrint('REGISTER ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Registration failed',
        'Unable to finish account setup. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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
