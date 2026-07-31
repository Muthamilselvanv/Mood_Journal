import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/pages/main_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/binding/main_binding.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/add_mood_entry.dart';

class AppPages {
  AppPages._(); // private constructor to prevent instantiation

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),

    GetPage(
      name: AppRoutes.addMoodEntry,
      page: () => const AddMoodEntry(),
    ), 
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const HomePage(),
  ); // this is the unknown route ( /not-found ) that will be used when the user navigates to a route that does not exist
}
