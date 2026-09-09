import 'package:flutter_test/flutter_test.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

void main() {
  test('round-trips a mood entry through its local database map', () {
    final createdAt = DateTime.utc(2026, 8, 31, 12, 30);
    final original = MoodEntry(
      id: 12,
      firebaseId: 'cloud-12',
      userId: 3,
      mood: 'Happy',
      weather: 'Sunny',
      activities: const ['Reading', 'Exercise'],
      intensity: 4,
      title: 'A good day',
      notes: 'Felt energised.',
      createdAt: createdAt,
      imageUrl: '/local/photo.jpg',
      isFavorite: true,
    );

    final restored = MoodEntry.fromMap(original.toMap());

    expect(restored.id, original.id);
    expect(restored.firebaseId, original.firebaseId);
    expect(restored.userId, original.userId);
    expect(restored.mood, original.mood);
    expect(restored.activities, original.activities);
    expect(restored.createdAt, createdAt);
    expect(restored.isFavorite, isTrue);
  });

  test('reads legacy comma-separated activities and integer favorite', () {
    final restored = MoodEntry.fromMap({
      'id': 2,
      'firebaseId': null,
      'userId': -1,
      'mood': 'Calm',
      'weather': 'Cloudy',
      'activities': 'Reading,Walking',
      'intensity': 3,
      'title': '',
      'notes': '',
      'createdAt': '2026-08-31T09:00:00.000Z',
      'imageUrl': null,
      'isFavorite': 1,
    });

    expect(restored.activities, ['Reading', 'Walking']);
    expect(restored.isFavorite, isTrue);
  });
}
