import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:mood_journal_app/src/features/profile/presentation/controllers/profile_controller.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;

  late String? imagePath;

  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.name);
    bioController = TextEditingController(text: widget.user.bio ?? "");
    imagePath = widget.user.profileImage;
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    await controller.pickProfileImage();

    setState(() {
      imagePath = controller.user.value?.profileImage;
    });
  }

  Future<void> _save() async {
    final currentUser = controller.user.value;

    if (currentUser == null) return;

    final updated = currentUser.copyWith(
      name: nameController.text.trim(),
      bio: bioController.text.trim(),
      profileImage: imagePath,
    );

    await controller.updateProfile(updated);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xff7C4DFF), Color(0xff5AA9FF)],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: imagePath != null
                            ? FileImage(File(imagePath!))
                            : null,
                        child: imagePath == null
                            ? Image.asset(AppAssets.niloraIcon, width: 58)
                            : null,
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff7C4DFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                "Edit Your Profile",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Keep your information up to date.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),

              const SizedBox(height: 32),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.user, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: isDark
                          ? Border.all(color: Colors.grey.shade700)
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.edit2, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Bio",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    minLines: 4,
                    maxLines: 5,
                    controller: bioController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Living one day at a time 🌿",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              AppGradientButton(
                text: "Save Changes",
                icon: LucideIcons.save,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
