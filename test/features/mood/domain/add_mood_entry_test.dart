import 'package:flutter_test/flutter_test.dart';
import 'package:mood_journal_app/src/core/errors/app_exception.dart';
import 'package:mood_journal_app/src/features/mood/domain/entities/mood_entry.dart';
import 'package:mood_journal_app/src/features/mood/domain/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/mood/domain/usecases/add_mood_entry.dart';

void main() {
  test('rejects an entry without a mood', () async {
    final useCase = AddMoodEntry(_FakeMoodRepository());
    final entry = MoodEntry(id: '1', mood: ' ', note: '', createdAt: DateTime(2026));

    expect(() => useCase(entry), throwsA(isA<AppException>()));
  });
}

class _FakeMoodRepository implements MoodRepository {
  @override
  Future<List<MoodEntry>> getEntries() async => [];

  @override
  Future<void> saveEntry(MoodEntry entry) async {}
}
