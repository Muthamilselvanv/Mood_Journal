import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/journal/presentation/widgets/journal_card.dart';

class JournalList extends GetView<JournalController> {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entries = controller.filteredEntries;

      if (entries.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.menu_book_rounded, // or Icons.book_outlined
                size: 72,
                color: Colors.grey,
              ),
              const SizedBox(height: 12),
              Text(
                "No journals found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return JournalCard(entry: entries[index]);
        },
      );
    });
  }
}
