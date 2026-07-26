import 'package:intl/intl.dart';

String formattedDate() {
  return DateFormat('EEEE, MMMM dd').format(DateTime.now());
  //return DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
}

String greeting() {
  final hour = DateTime.now().hour;

  final String userName = 'Muthu';

  if (hour < 12) {
    return "Good Morning $userName 👋";
  } else if (hour < 17) {
    return "Good Afternoon $userName ☀️";
  } else {
    return "Good Evening $userName 🌙";
  }
}
