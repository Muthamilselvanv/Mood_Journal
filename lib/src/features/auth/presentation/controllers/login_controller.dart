import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/data/repositories/user_repository.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameError = RxnString();
  final passwordError = RxnString();

  final obscurePassword = true.obs;

  final isLoading = false.obs;

  final UserRepository repository = Get.find<UserRepository>();

  void togglePassword() {
    obscurePassword.toggle();
  }

  Future<void> login() async {
    usernameError.value = null;
    passwordError.value = null;

    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty) {
      usernameError.value = "Username is required";
    }

    if (password.isEmpty) {
      passwordError.value = "Password is required";
    }

    if (usernameError.value != null || passwordError.value != null) {
      return;
    }

    isLoading.value = true;

    final user = await repository.login(username: username, password: password);

    isLoading.value = false;

    if (user == null) {
      passwordError.value = "Invalid username or password";

      return;
    }

    final box = GetStorage();

    box.write("isLoggedIn", true);
    box.write("userId", user.id);
    box.write("name", user.name);
    box.write("userName", user.username);
    box.write("password", user.password);
    box.write("bio", user.bio);
    box.write("isGuest", false);

    Get.offAllNamed(AppRoutes.home);
  }

  //forgot password
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

  // @override
  // void onClose() {
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
