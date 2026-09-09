import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_select_model.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/mood_select/mood_item.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/about/privacy_policy_page.dart';
import 'package:mood_journal_app/src/features/profile/presentation/widgets/profile_image.dart';

void main() {
  testWidgets('privacy policy identifies Nilora and its effective date', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PrivacyPolicyPage()));

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Nilora Privacy Policy'), findsOneWidget);
    expect(find.text('Effective 31 August 2026'), findsOneWidget);
  });

  testWidgets('compact Neutral mood tile keeps its label on one line', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: MoodItem(
              mood: const MoodModel(
                emoji: '😐',
                title: 'Neutral',
                message: 'A steady day.',
                color: Colors.blue,
              ),
              selected: false,
              compact: true,
              onTap: _noop,
            ),
          ),
        ),
      ),
    );

    final label = tester.widget<Text>(find.text('Neutral'));
    expect(label.maxLines, 1);
    expect(label.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);
  });

  testWidgets('missing local profile photo falls back without crashing', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileImage(imagePath: 'missing/profile/photo.jpg', size: 108),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

void _noop() {}
