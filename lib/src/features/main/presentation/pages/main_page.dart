import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/journal/presentation/pages/journal_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/features/main/presentation/widgets/app_bottom_navigation.dart';
import 'package:mood_journal_app/src/features/profile/presentation/pages/profile_page.dart';
import 'package:mood_journal_app/src/features/trends/presentation/pages/trends_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomePage(),
            JournalPage(),
            TrendsPages(),
            ProfilePage(),
          ],
        ),

        bottomNavigationBar: AppBottomNavigation(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTap,
        ),
      ),
    );
  }
}
