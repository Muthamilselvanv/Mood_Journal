import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'bio': '',
      'profileImage': null,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserProfile({
    required String uid,
    required String name,
    required String bio,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'bio': bio,
      'profileImage': FieldValue.delete(),
    });
  }
}
