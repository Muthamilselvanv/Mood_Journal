import 'package:firebase_auth/firebase_auth.dart';
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

  final isResettingPassword = false.obs;

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
      final profileImage = profile['profileImage']?.toString().trim();
      final bio = profile['bio']?.toString();

      if (name.isEmpty || userEmail.isEmpty) {
        throw StateError('Firestore profile is incomplete.');
      }

      // 3. Recreate SQLite user after reinstall, or use its existing local ID.
      final localUserId = await repository.insertUser(
        firebaseUid: firebaseUser.uid,
        name: name,
        email: userEmail,
        profileImage: profileImage?.isEmpty == true ? null : profileImage,
        bio: bio,
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
    } on FirebaseAuthException catch (error) {
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
        case 'network-request-failed':
          Get.snackbar(
            'Internet connection required',
            'Check your Wi-Fi or mobile data and try again.',
            snackPosition: SnackPosition.BOTTOM,
          );
          break;
        default:
          passwordError.value = error.message ?? 'Unable to sign in';
      }
    } on FirebaseException catch (_) {
      Get.snackbar(
        'Cloud data error',
        'Sign-in succeeded, but your profile or journals could not be loaded. '
            'Check your connection and Firestore rules.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on StateError catch (error) {
      Get.snackbar(
        'Account setup error',
        error.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Login failed',
        'Something went wrong while restoring your local data.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showForgotPasswordDialog() {
    Get.dialog(
      _ForgotPasswordDialog(initialEmail: emailController.text.trim()),
    );
  }

  Future<bool> resetPassword(String email) async {
    isResettingPassword.value = true;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (error) {
      final message = switch (error.code) {
        'invalid-email' => 'Enter a valid email address.',
        'user-not-found' =>
          'No account uses this email. Please create an account first.',
        'network-request-failed' =>
          'No internet connection. Connect to Wi-Fi or mobile data and try again.',
        'too-many-requests' =>
          'Too many requests. Please wait a few minutes and try again.',
        _ => 'Unable to send the reset email. Please try again.',
      };

      Get.snackbar(
        'Password reset unavailable',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } catch (_) {
      Get.snackbar(
        'Could not send reset link',
        'Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isResettingPassword.value = false;
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

class _ForgotPasswordDialog extends StatefulWidget {
  const _ForgotPasswordDialog({required this.initialEmail});

  final String initialEmail;

  @override
  State<_ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<_ForgotPasswordDialog> {
  late final TextEditingController _emailController;
  final LoginController _loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    final email = _emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid email',
        'Enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final sent = await _loginController.resetPassword(email);
    if (!sent || !mounted) return;

    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.snackbar(
        'Reset link sent',
        'Check your Inbox, Spam, or Promotions folder.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset password'),
      content: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _sendResetLink(),
        decoration: const InputDecoration(
          labelText: 'Email address',
          hintText: 'you@example.com',
        ),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        Obx(
          () => FilledButton(
            onPressed: _loginController.isResettingPassword.value
                ? null
                : _sendResetLink,
            child: _loginController.isResettingPassword.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Send reset link'),
          ),
        ),
      ],
    );
  }
}
