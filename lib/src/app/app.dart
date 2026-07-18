import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/app/app_pages.dart';
import 'package:mood_journal_app/src/app/bindings/initial_binding.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/app/theme/app_theme.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Journal',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      unknownRoute: AppPages.unknownRoute,
    );
  }
}
