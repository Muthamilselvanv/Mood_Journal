import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_assets.dart';

class EditProfileSheet extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onImageTap;

  final TextEditingController nameController;
  final TextEditingController bioController;

  final VoidCallback onSave;

  const EditProfileSheet({
    super.key,
    required this.imagePath,
    required this.onImageTap,
    required this.nameController,
    required this.bioController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .85,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Edit Profile",
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 24),

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : null,
                    child: imagePath == null
                        ? Image.asset(
                            AppAssets.niloraIcon,
                            width: 230,
                            fit: BoxFit.contain,
                            color: Color(0xff7C4DFF),
                          )
                        : null,
                  ),

                  FloatingActionButton.small(
                    heroTag: null,
                    elevation: 0,
                    backgroundColor: const Color(0xff7C4DFF),
                    onPressed: onImageTap,
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: bioController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: "Bio",
                          prefixIcon: Icon(Icons.edit_note),
                          alignLabelWithHint: true,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          onPressed: onSave,
                          child: const Text("Save Changes"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
