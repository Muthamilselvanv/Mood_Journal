class AppException implements Exception {
  const AppException(this.message, {this.cause});
  final String message;
  final Object? cause;
  @override
  String toString() => message;
}

//throw const AppException('Please select a mood.');

// message is user-friendly text.
// cause can store the original technical error.
// toString() ensures showing the error displays the message cleanly.