import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () {

          Get.defaultDialog(
            title: "Logout",
            middleText: "Are you sure you want to logout?",

            textCancel: "Cancel",

            textConfirm: "Logout",

            confirmTextColor: Colors.white,

            onConfirm: () {
              Get.back();

              // TODO:
              // Clear Login
              // Navigate Login Page
            },
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFFF1F2),
          foregroundColor: Colors.redAccent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        icon: const Icon(Icons.logout),

        label: const Text(
          "Log Out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}