import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class MoodFirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _requireCurrentUid() {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No Firebase user is signed in.');
    }
    return user.uid;
  }

  Future<String> addMoodEntry(MoodEntry entry) async {
    final uid = _requireCurrentUid();

    final docRef = await _firestore.collection('mood_entries').add({
      'userId': uid,
      'mood': entry.mood,
      'weather': entry.weather,
      'activities': entry.activities,
      'intensity': entry.intensity,
      'title': entry.title,
      'notes': entry.notes,
      'createdAt': Timestamp.fromDate(entry.createdAt),
      'isFavorite': entry.isFavorite,
      'imageUrl': entry.imageUrl,
    });

    return docRef.id;
  }

  Future<void> updateMoodEntry(MoodEntry entry) async {
    final uid = _requireCurrentUid();

    if (entry.firebaseId == null || entry.firebaseId!.isEmpty) {
      throw ArgumentError('Firebase ID is required to update a journal entry.');
    }

    await _firestore.collection('mood_entries').doc(entry.firebaseId).update({
      'userId': uid,
      'mood': entry.mood,
      'weather': entry.weather,
      'activities': entry.activities,
      'intensity': entry.intensity,
      'title': entry.title,
      'notes': entry.notes,
      'createdAt': Timestamp.fromDate(entry.createdAt),
      'isFavorite': entry.isFavorite,
      'imageUrl': entry.imageUrl,
    });
  }

  Future<void> deleteMoodEntry(String firebaseId) async {
    _requireCurrentUid();
    await _firestore.collection('mood_entries').doc(firebaseId).delete();
  }

  Future<void> toggleFavorite(String firebaseId, bool isFavorite) async {
    _requireCurrentUid();

    await _firestore.collection('mood_entries').doc(firebaseId).update({
      'isFavorite': isFavorite,
    });
  }

  Future<List<MoodEntry>> getMoodEntries(String firebaseUid) async {
    final currentUid = _requireCurrentUid();

    if (firebaseUid != currentUid) {
      throw StateError('Cannot load journal entries for another user.');
    }

    final snapshot = await _firestore
        .collection('mood_entries')
        .where('userId', isEqualTo: currentUid)
        .get();

    final entries = snapshot.docs.map((doc) {
      final data = doc.data();
      final rawCreatedAt = data['createdAt'];

      final createdAt = rawCreatedAt is Timestamp
          ? rawCreatedAt.toDate()
          : rawCreatedAt is DateTime
          ? rawCreatedAt
          : DateTime.tryParse(rawCreatedAt?.toString() ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0);

      final rawActivities = data['activities'];
      final activities = rawActivities is List
          ? rawActivities.map((item) => item.toString()).toList()
          : <String>[];

      return MoodEntry(
        firebaseId: doc.id,
        userId: 0,
        mood: data['mood']?.toString() ?? '',
        weather: data['weather']?.toString() ?? '',
        activities: activities,
        intensity: (data['intensity'] as num?)?.toInt() ?? 0,
        title: data['title']?.toString() ?? '',
        notes: data['notes']?.toString() ?? '',
        createdAt: createdAt,
        imageUrl: data['imageUrl'] as String?,
        isFavorite: data['isFavorite'] == true,
      );
    }).toList();

    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }
}
