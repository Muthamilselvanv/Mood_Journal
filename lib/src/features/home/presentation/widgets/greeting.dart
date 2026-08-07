import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

String formattedDate() {
  return DateFormat('EEEE, MMMM dd').format(DateTime.now());
  //return DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
}

String formatAddDate() {
  return DateFormat('dd-MM-yyyy').format(DateTime.now());
}

String greeting() {
  final hour = DateTime.now().hour;

  // final String userName = 'Muthu';
  final box = GetStorage();

  final name = box.read("userName") ?? "Guest";

  if (hour < 12) {
    return "Good Morning $name 👋";
  } else if (hour < 17) {
    return "Good Afternoon $name ☀️";
  } else {
    return "Good Evening $name 🌙";
  }
}
