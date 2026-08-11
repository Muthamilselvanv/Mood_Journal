import 'dart:convert';

class MoodEntry {
  final int? id;
  final String? firebaseId;
  final int userId;
  final String mood;
  final String weather;
  final List<String> activities;
  final int intensity;
  final String title;
  final String notes;
  final DateTime createdAt;
  final String? imageUrl;
  final bool isFavorite;

  const MoodEntry({
    this.id,
    this.firebaseId,
    required this.userId,
    required this.mood,
    required this.weather,
    required this.activities,
    required this.intensity,
    required this.title,
    required this.notes,
    required this.createdAt,
    this.imageUrl,
    this.isFavorite = false,
  });

  MoodEntry copyWith({
    int? id,
    String? firebaseId,
    int? userId,
    String? mood,
    String? weather,
    List<String>? activities,
    int? intensity,
    String? title,
    String? notes,
    DateTime? createdAt,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      firebaseId: firebaseId ?? this.firebaseId,
      userId: userId ?? this.userId,
      mood: mood ?? this.mood,
      weather: weather ?? this.weather,
      activities: activities ?? this.activities,
      intensity: intensity ?? this.intensity,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    return {
      if (includeId && id != null) 'id': id,
      'userId': userId,
      'firebaseId': firebaseId,
      'mood': mood,
      'weather': weather,
      'activities': jsonEncode(activities),
      'intensity': intensity,
      'title': title,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    final rawActivities = map['activities'];

    List<String> activities;
    if (rawActivities is List) {
      activities = rawActivities.map((item) => item.toString()).toList();
    } else {
      final value = rawActivities?.toString() ?? '';

      try {
        final decoded = jsonDecode(value);
        activities = decoded is List
            ? decoded.map((item) => item.toString()).toList()
            : <String>[];
      } catch (_) {
        // Compatibility with old records saved as "Reading,Exercise".
        activities = value.isEmpty ? <String>[] : value.split(',');
      }
    }

    final favorite = map['isFavorite'];

    return MoodEntry(
      id: map['id'] as int?,
      firebaseId: map['firebaseId'] as String?,
      userId: map['userId'] as int,
      mood: map['mood']?.toString() ?? '',
      weather: map['weather']?.toString() ?? '',
      activities: activities,
      intensity: (map['intensity'] as num?)?.toInt() ?? 0,
      title: map['title']?.toString() ?? '',
      notes: map['notes']?.toString() ?? '',
      createdAt: DateTime.parse(map['createdAt'].toString()),
      imageUrl: map['imageUrl'] as String?,
      isFavorite: favorite == true || favorite == 1,
    );
  }
}
