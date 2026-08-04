class DatabaseTables {
  DatabaseTables._();

  // Tables
  static const moods = "moods";
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
  static const imagePath = "imagePath";
  static const createdAt = "createdAt";
  static const isFavorite = "isFavorite";

  // User Columns
  static const userId = "id";
  static const name = "name";
  static const username = "username";
  static const password = "password";
  static const userCreatedAt = "createdAt";
}