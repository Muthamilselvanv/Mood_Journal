import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';

class RegisterController extends GetxController {
  final UserRepository _repository = Get.find<UserRepository>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameError = RxnString();
  final usernameError = RxnString();
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

    usernameController.addListener(() => usernameError.value = null);

    passwordController.addListener(() => passwordError.value = null);

    confirmPasswordController.addListener(
      () => confirmPasswordError.value = null,
    );
  }

  Future<void> register() async {
    nameError.value = null;
    usernameError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;

    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool valid = true;

    if (name.isEmpty) {
      nameError.value = "Please enter your name";
      valid = false;
    }

    if (username.isEmpty) {
      usernameError.value = "Username is required";
      valid = false;
    } else if (username.length < 4) {
      usernameError.value = "Minimum 4 characters";
      valid = false;
    }

    if (password.isEmpty) {
      passwordError.value = "Password is required";
      valid = false;
    } else if (password.length < 6) {
      passwordError.value = "Minimum 6 characters";
      valid = false;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Confirm your password";
      valid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = "Passwords do not match";
      valid = false;
    }

    if (!valid) return;

    isLoading.value = true;

    try {
      /// Check username already exists
      final exists = await _repository.usernameExists(username);

      if (exists) {
        usernameError.value = "Username already exists";
        return;
      }

      final user = UserModel(
        name: name,
        username: username,
        password: password,
        createdAt: DateTime.now(),
      );

      await _repository.register(user);

      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // @override
  // void onClose() {
  //   nameController.dispose();
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.onClose();
  // }
}
