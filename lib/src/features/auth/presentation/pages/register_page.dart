import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/register_controller.dart';
import 'package:mood_journal_app/src/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text("Create Account"),
      ),
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
              children: [
                const SizedBox(height: AppSpacing.space8),

                Image.asset(
                  Get.isDarkMode ? AppAssets.logoDark : AppAssets.logoLight,
                  width: 120,
                ),

                const SizedBox(height: AppSpacing.space8),

                Text(
                  "Create Your Account",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  "Start tracking your emotions and build healthy habits.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                Obx(
                  () => AuthTextField(
                    controller: controller.nameController,
                    hint: "Full Name",
                    icon: LucideIcons.userCircle,
                    errorText: controller.nameError.value,
                  ),
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                Obx(
                  () => AuthTextField(
                    controller: controller.confirmPasswordController,
                    hint: "Confirm Password",
                    icon: LucideIcons.lock,
                    obscure: controller.obscureConfirmPassword.value,
                    errorText: controller.confirmPasswordError.value,
                    suffix: IconButton(
                      onPressed: controller.toggleConfirmPassword,
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? LucideIcons.eye
                            : LucideIcons.eyeOff,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 54,
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
                                await controller.register();
                              },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          disabledForegroundColor: Colors.white70,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                LucideIcons.userPlus,
                                color: Colors.white,
                              ),
                        label: Text(
                          controller.isLoading.value
                              ? "Creating Account..."
                              : "Create Account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.login);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
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
