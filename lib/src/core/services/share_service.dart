import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class ShareService {
  static Future<void> shareMood(MoodEntry entry) async {
    final date = DateFormat(
      "EEEE, dd MMM yyyy • hh:mm a",
    ).format(entry.createdAt);

    final text =
        '''
🌸 MY MOOD JOURNAL 🌸

📅 Date
$date

😊 Mood
${entry.mood}

🌤 Weather
${entry.weather}

💪 Mood Intensity
${entry.intensity}/10

🎯 Activities
${entry.activities.isEmpty ? "No activities recorded" : entry.activities.join(" • ")}

📝 Journal Title
${entry.title}

💭 Notes
${entry.notes}

━━━━━━━━━━━━━━━━━━━━━
✨ Every day is a fresh start.
💜 Created with Mood Journal
━━━━━━━━━━━━━━━━━━━━━
''';

    if (entry.imageUrl != null && File(entry.imageUrl!).existsSync()) {
      await SharePlus.instance.share(
        ShareParams(
          text: text,
          subject: "Mood Journal - ${entry.title}",
          files: [XFile(entry.imageUrl!)],
        ),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(text: text, subject: "Mood Journal - ${entry.title}"),
      );
    }
  }
}
