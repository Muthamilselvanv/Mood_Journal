enum StartupSessionAction {
  openGuestHome,
  openSignedOut,
  verifyFirebaseSession,
}

StartupSessionAction decideStartupSession({
  required bool isLoggedIn,
  required bool isGuest,
  required int? localUserId,
  required bool hasFirebaseUser,
}) {
  if (isLoggedIn && isGuest && localUserId == -1) {
    return StartupSessionAction.openGuestHome;
  }

  if (!hasFirebaseUser) {
    return StartupSessionAction.openSignedOut;
  }

  return StartupSessionAction.verifyFirebaseSession;
}
