import 'package:flutter_test/flutter_test.dart';
import 'package:mood_journal_app/src/features/auth/domain/startup_session_decision.dart';

void main() {
  test('opens home for a complete guest session', () {
    expect(
      decideStartupSession(
        isLoggedIn: true,
        isGuest: true,
        localUserId: -1,
        hasFirebaseUser: false,
      ),
      StartupSessionAction.openGuestHome,
    );
  });

  test('rejects a stale guest session without the guest user id', () {
    expect(
      decideStartupSession(
        isLoggedIn: true,
        isGuest: true,
        localUserId: null,
        hasFirebaseUser: false,
      ),
      StartupSessionAction.openSignedOut,
    );
  });

  test('rejects a saved account session when Firebase is signed out', () {
    expect(
      decideStartupSession(
        isLoggedIn: true,
        isGuest: false,
        localUserId: 7,
        hasFirebaseUser: false,
      ),
      StartupSessionAction.openSignedOut,
    );
  });

  test('verifies or restores a session when Firebase has a user', () {
    expect(
      decideStartupSession(
        isLoggedIn: false,
        isGuest: false,
        localUserId: null,
        hasFirebaseUser: true,
      ),
      StartupSessionAction.verifyFirebaseSession,
    );
  });
}
