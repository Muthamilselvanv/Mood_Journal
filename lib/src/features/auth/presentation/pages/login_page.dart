import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/login_controller.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/auth_text_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space20,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Image.asset(
                  Get.isDarkMode ? AppAssets.logoDark : AppAssets.logoLight,
                  width: 120,
                ),

                const SizedBox(height: AppSpacing.space8),

                Text("Welcome Back", style: theme.textTheme.headlineMedium),

                const SizedBox(height: 8),

                Text(
                  "Sign in to continue your mood journey.",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                Obx(
                  () => AuthTextField(
                    controller: controller.usernameController,
                    hint: "Username",
                    icon: LucideIcons.user,
                    errorText: controller.usernameError.value,
                  ),
                ),

                const SizedBox(height: 20),

                Obx(
                  () => AuthTextField(
                    controller: controller.passwordController,
                    hint: "Password",
                    icon: LucideIcons.lock,
                    obscure: controller.obscurePassword.value,
                    errorText: controller.passwordError.value,
                    suffix: IconButton(
                      onPressed: controller.togglePassword,
                      icon: Icon(
                        controller.obscurePassword.value
                            ? LucideIcons.eye
                            : LucideIcons.eyeOff,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      controller.popUp();
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xff7C4DFF)),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xff7C4DFF), Color(0xff5AA9FF)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7C4DFF).withOpacity(.25),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              await controller.login();
                            },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: const Icon(LucideIcons.logIn, color: Colors.white),
                      label: Text(
                        controller.isLoading.value
                            ? "Signing In..."
                            : "Sign In",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xff7C4DFF), Color(0xff5AA9FF)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7C4DFF).withOpacity(.25),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final box = GetStorage();

                        box.write("isLoggedIn", true);
                        box.write("isGuest", true);
                        box.write("userId", -1);
                        box.write("userName", "Guest");

                        Get.offAllNamed(AppRoutes.home);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: const Icon(LucideIcons.user, color: Colors.white),
                      label: const Text(
                        "Continue as Guest",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),

                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Color(0xff7C4DFF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
