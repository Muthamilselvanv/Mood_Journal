import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/journal/presentation/pages/mood_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/pages/main_page.dart';
import 'package:mood_journal_app/src/features/profile/presentation/pages/profile.dart';
import 'package:mood_journal_app/src/features/trends/presentation/pages/trends.dart';
import 'package:mood_journal_app/src/features/main/presentation/binding/main_binding.dart';

class AppPages {
  AppPages._(); // private constructor to prevent instantiation

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const MainPage(),
      binding: MainBinding(),
    ), // this is the home page ( / ) route

    GetPage(
      name: AppRoutes.journal,
      page: () => const JournalPage(), // very important: this binding will be used to inject dependencies for the mood page before the page is created
    ),
    GetPage(name: AppRoutes.trends, page: () => const TrendsPages()),
    // (/mood) route for the mood page + MoodBinding
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const HomePage(),
  ); // this is the unknown route ( /not-found ) that will be used when the user navigates to a route that does not exist
}
