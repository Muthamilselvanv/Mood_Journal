import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/core/database/database_helper.dart';

class AccountDeletionService {
  AccountDeletionService._();

  static final instance = AccountDeletionService._();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> deleteCurrentAccount(String password) async {
    final user = _auth.currentUser;
    final email = user?.email;

    if (user == null || email == null) {
      throw StateError('No password-based account is signed in.');
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);

    final journals = await _firestore
        .collection('mood_entries')
        .where('userId', isEqualTo: user.uid)
        .get();

    for (var start = 0; start < journals.docs.length; start += 400) {
      final end = start + 400 < journals.docs.length
          ? start + 400
          : journals.docs.length;
      final batch = _firestore.batch();
      for (final document in journals.docs.sublist(start, end)) {
        batch.delete(document.reference);
      }
      await batch.commit();
    }

    await _firestore.collection('users').doc(user.uid).delete();
    await user.delete();
    await _deleteLocalData();
  }

  Future<void> _deleteLocalData() async {
    final box = GetStorage();
    final localUserId = box.read<int>('userId');

    const sessionKeys = <String>[
      'isLoggedIn',
      'isGuest',
      'firebaseUid',
      'userId',
      'name',
      'userName',
      'email',
    ];

    try {
      if (localUserId != null) {
        final database = await DatabaseHelper.instance.database;
        await database.transaction((transaction) async {
          await transaction.delete(
            'mood_entries',
            where: 'userId = ?',
            whereArgs: [localUserId],
          );
          await transaction.delete(
            'users',
            where: 'id = ?',
            whereArgs: [localUserId],
          );
        });
      }
    } finally {
      for (final key in sessionKeys) {
        await box.remove(key);
      }
    }
  }
}
