import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/constants/app_design_tokens.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to Mood Journal',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              AppGradientButton(
                label: 'Manage mood entries',
                icon: Icons.sentiment_satisfied_alt,
                onPressed: () {
                  Get.toNamed(AppRoutes.mood);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
