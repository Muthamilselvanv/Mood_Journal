import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome to Mood Journal', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.mood);
              },
              child: const Text('Manage mood entries'),
            ),
          ],
        ),
      ),
    );
  }
}
