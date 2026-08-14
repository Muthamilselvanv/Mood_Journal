import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/core/services/image_picker_service.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/profile/data/repositories/profile_repository.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/edit_profile_page.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = Get.find<ProfileRepository>();
  final _box = GetStorage();

  final user = Rxn<UserModel>();
  final isLoading = false.obs;
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;

    try {
      final userId = _box.read<int>('userId');

      if (userId == null) {
        user.value = null;
        return;
      }

      user.value = await _repository.getUser(userId);
    } catch (error, stackTrace) {
      debugPrint('PROFILE LOAD ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Profile unavailable',
        'Your profile could not be loaded. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    if (updatedUser.name.trim().isEmpty) {
      Get.snackbar(
        'Name required',
        'Please enter your name.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSaving.value = true;

    try {
      await _repository.updateProfile(updatedUser);

      user.value = updatedUser;
      await _box.write('name', updatedUser.name);

      Get.snackbar(
        'Profile updated',
        'Your changes have been saved.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error, stackTrace) {
      debugPrint('PROFILE UPDATE ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Could not save profile',
        'Check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );

      rethrow;
    } finally {
      isSaving.value = false;
    }
  }

  /// Select only. The image is saved when the user presses Save Changes.
  Future<String?> pickProfileImage() async {
    try {
      final image = await ImagePickerService.pickFromGallery();
      return image?.path;
    } catch (error, stackTrace) {
      debugPrint('PROFILE IMAGE ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      Get.snackbar(
        'Image unavailable',
        'We could not open your gallery. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  void editProfile() {
    final currentUser = user.value;

    if (currentUser == null) {
      Get.snackbar(
        'Profile unavailable',
        'Please wait for your profile to load.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.to(() => EditProfilePage(user: currentUser));
  }
}
