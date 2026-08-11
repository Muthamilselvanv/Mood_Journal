class DatabaseTables {
  DatabaseTables._();

  // Tables
  static const moods = "mood_entries";
  static const users = "users";

  // Mood Columns
  static const moodId = "id";
  static const moodUserId = "userId";
  static const mood = "mood";
  static const weather = "weather";
  static const activities = "activities";
  static const intensity = "intensity";
  static const title = "title";
  static const notes = "notes";
  static const imageUrl = "imageUrl";
  static const createdAt = "createdAt";
  static const isFavorite = "isFavorite";

  // User Columns
  static const userId = "id";
  static const firebaseUid = "firebaseUid";
  static const email = "email";
  static const name = "name";
  static const profileImage = "profileImage";
  static const bio = "bio";
  static const userCreatedAt = "createdAt";
}
