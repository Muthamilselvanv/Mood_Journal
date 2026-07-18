import 'package:mood_journal_app/src/features/mood/domain/entities/mood_entry.dart';

class MoodEntryModel {
  const MoodEntryModel({required this.id, required this.mood, required this.note, required this.createdAt});

  final String id;
  final String mood;
  final String note;
  final DateTime createdAt;

  factory MoodEntryModel.fromEntity(MoodEntry entry) => MoodEntryModel(
        id: entry.id,
        mood: entry.mood,
        note: entry.note,
        createdAt: entry.createdAt,
      );

  factory MoodEntryModel.fromMap(Map<String, Object?> map) => MoodEntryModel(
        id: map['id']! as String,
        mood: map['mood']! as String,
        note: map['note']! as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']! as int),
      );

  MoodEntry toEntity() => MoodEntry(id: id, mood: mood, note: note, createdAt: createdAt);

  Map<String, Object?> toMap() => {
        'id': id,
        'mood': mood,
        'note': note,
        'created_at': createdAt.millisecondsSinceEpoch,
      };
}
