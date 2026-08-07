import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/profile/data/repositories/profile_repository.dart';
import 'package:mood_journal_app/src/core/services/image_picker_service.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/edit_profile_page.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = Get.find<ProfileRepository>();

  final _box = GetStorage();

  final user = Rxn<UserModel>();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;

    try {
      final userId = _box.read("userId");

      if (userId == null) {
        user.value = null;
        return;
      }

      final result = await _repository.getUser(userId);

      user.value = result;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    await _repository.updateProfile(updatedUser);

    user.value = updatedUser;
  }

  Future<void> pickProfileImage() async {
    final image = await ImagePickerService.pickFromGallery();

    if (image == null || user.value == null) return;

    final updatedUser = user.value!.copyWith(profileImage: image.path);

    await updateProfile(updatedUser);
  }

  void editProfile() {
    Get.to(() => EditProfilePage(user: user.value!));
  }

}
