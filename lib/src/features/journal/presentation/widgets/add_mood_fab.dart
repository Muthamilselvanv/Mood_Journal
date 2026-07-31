import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';

class AddMoodFAB extends StatelessWidget {
  const AddMoodFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xff8B5CF6), Color(0xff5DA8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff8B5CF6).withOpacity(.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Get.toNamed(AppRoutes.addMoodEntry);
          },
          child: const Center(
            child: Icon(Icons.add, color: Colors.white, size: 34),
          ),
        ),
      ),
    );
  }
}
