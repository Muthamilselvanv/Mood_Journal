import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/bindings/login_binding.dart';
import 'package:mood_journal_app/src/features/auth/bindings/onboarding_binding.dart';
import 'package:mood_journal_app/src/features/auth/bindings/register_binding.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/onboarding_page.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/register_page.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/pages/main_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/binding/main_binding.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/add_mood_entry.dart';

class AppPages {
  AppPages._(); // private constructor to prevent instantiation

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),

    GetPage(name: AppRoutes.addMoodEntry, page: () => const AddMoodEntry()),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const HomePage(),
  ); // this is the unknown route ( /not-found ) that will be used when the user navigates to a route that does not exist
}
