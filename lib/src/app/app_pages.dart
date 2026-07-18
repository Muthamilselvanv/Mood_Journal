import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/mood/presentation/bindings/mood_binding.dart';
import 'package:mood_journal_app/src/features/mood/presentation/pages/mood_page.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.mood,
      page: () => const MoodPage(),
      binding: MoodBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const HomePage(),
  );
}
