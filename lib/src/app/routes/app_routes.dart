// Usage: AppRoutes.home, AppRoutes.mood, AppRoutes.notFound

import 'package:mood_journal_app/src/features/journal/domain/usecases/add_mood_entry.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const journal = '/journal';
  static const trends = '/trends';
  static const profile = '/profile';
  static const addMoodEntry = '/addmoodentry';
  static const notFound = '/not-found';
}
