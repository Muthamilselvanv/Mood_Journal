import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/features/auth/bindings/login_binding.dart';
import 'package:mood_journal_app/src/features/auth/bindings/onboarding_binding.dart';
import 'package:mood_journal_app/src/features/auth/bindings/register_binding.dart';
import 'package:mood_journal_app/src/features/auth/bindings/splash_binding.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/onboarding_page.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/register_page.dart';
import 'package:mood_journal_app/src/features/auth/presentation/pages/splash_page.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/pages/main_page.dart';
import 'package:mood_journal_app/src/features/main/presentation/binding/main_binding.dart';
import 'package:mood_journal_app/src/features/home/presentation/pages/add_mood_entry.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/about/about_page.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/about/app_info_page.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/about/contact_support_page.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/about/terms_conditions_page.dart';

class AppPages {
  AppPages._(); // private constructor to prevent instantiation

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
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

    GetPage(name: AppRoutes.support, page: () => const ContactSupportPage()),
    GetPage(name: AppRoutes.about, page: () => const AboutPage()),
    GetPage(name: AppRoutes.privacy, page: () => const AppInfoPage()),
    GetPage(name: AppRoutes.terms, page: () => const TermsConditionsPage()),
    //GetPage(name: AppRoutes.rate, page: () => const RateAppPage()),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const HomePage(),
  ); // this is the unknown route ( /not-found ) that will be used when the user navigates to a route that does not exist
}
