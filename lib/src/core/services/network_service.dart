import 'dart:async';
import 'dart:io';

class NetworkService {
  NetworkService._();

  static Future<bool> hasInternetConnection() async {
    try {
      final addresses = await InternetAddress.lookup(
        'firebase.googleapis.com',
      ).timeout(const Duration(seconds: 4));

      return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
