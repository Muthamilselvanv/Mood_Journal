import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mood_journal_app/src/core/services/network_service.dart';
import 'package:mood_journal_app/src/shared/widgets/app_snackbar.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (!await NetworkService.hasInternetConnection()) {
      AppSnackbar.warning(
        'You are offline. Guest journals remain available, but cloud features '
        'need an internet connection.',
      );
    }
  });
}
