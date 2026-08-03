class MoodEntry {
  final int? id;
  final String mood;
  final String weather;
  final List<String> activities;
  final int intensity;
  final String title;
  final String notes;
  final DateTime createdAt;
  final String? imagePath;
  final bool isFavorite;

  const MoodEntry({
    this.id,
    required this.mood,
    required this.weather,
    required this.activities,
    required this.intensity,
    required this.title,
    required this.notes,
    required this.createdAt,
    this.imagePath,
    this.isFavorite = false,
  });

  MoodEntry copyWith({
    int? id,
    String? mood,
    String? weather,
    List<String>? activities,
    int? intensity,
    String? title,
    String? notes,
    DateTime? createdAt,
    String? imagePath,
    bool? isFavorite,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      weather: weather ?? this.weather,
      activities: activities ?? this.activities,
      intensity: intensity ?? this.intensity,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  //Convert to JSON / SQLite Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mood": mood, //happy, angry, sad
      "weather": weather, //sunny, cloud
      "activities": activities.join(","), // Exercise,Reading,Work
      "intensity": intensity, // 1/10
      "title": title,
      "notes": notes,
      "createdAt": createdAt.toIso8601String(),
      "imagePath": imagePath,
      "isFavorite": isFavorite ? 1 : 0,
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map["id"],
      mood: map["mood"],
      weather: map["weather"],
      activities: map["activities"].toString().split(","),
      intensity: map["intensity"],
      title: map["title"],
      notes: map["notes"],
      createdAt: DateTime.parse(map["createdAt"]),
      imagePath: map["imagePath"],
      isFavorite: map["isFavorite"] == 1,
    );
  }
}
