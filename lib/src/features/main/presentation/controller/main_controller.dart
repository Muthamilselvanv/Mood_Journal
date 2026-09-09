import 'dart:async';

import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changeTap(int index) {
    currentIndex.value = index;

    if (index == 3 && Get.isRegistered<JournalController>()) {
      unawaited(Get.find<JournalController>().loadEntries());
    }
  }
}
