import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';

class ProfileController extends GetxController {
  final controller = Get.find<JournalController>();
  
  String get memberSince {
    if (controller.moodEntries.isEmpty) return "";

    final first = controller.moodEntries.last.createdAt;

    return DateFormat("MMM yyyy").format(first);
  }
}
