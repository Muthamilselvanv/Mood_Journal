import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_design_tokens.dart';
import 'package:mood_journal_app/src/core/constants/mood_palette.dart';
import 'package:mood_journal_app/src/features/mood/presentation/controllers/mood_controller.dart';
import 'package:mood_journal_app/src/shared/widgets/app_gradient_button.dart';

class MoodPage extends GetView<MoodController> {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood entries')),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.value != null) {
            return Center(child: Text(controller.errorMessage.value!));
          }
          if (controller.entries.isEmpty) {
            return const Center(
              child: Text('No mood entries yet. Tap Add entry to begin.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final entry = controller.entries[index];
              final palette = MoodPalette.fromMood(entry.mood);
              return Card(
                color: palette.lightBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadii.medium,
                  side: BorderSide(
                    color: palette.color.withValues(alpha: 0.18),
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadii.full,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(palette.emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  title: Text(
                    entry.mood,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(entry.note.isEmpty ? 'No note' : entry.note),
                  trailing: Text('${entry.createdAt.day}/${entry.createdAt.month}'),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntrySheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add entry'),
      ),
    );
  }

  Future<void> _showAddEntrySheet(BuildContext context) async {
    final noteController = TextEditingController();
    String selectedMood = 'Happy';
    await Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How are you feeling?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedMood,
                  items: const ['Happy', 'Calm', 'Neutral', 'Sad', 'Angry']
                      .map(
                        (mood) => DropdownMenuItem(
                          value: mood,
                          child: Text(mood),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setSheetState(() => selectedMood = value ?? selectedMood),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: 'Note (optional)'),
                ),
                const SizedBox(height: 16),
                AppGradientButton(
                  label: 'Save mood',
                  icon: Icons.check,
                  onPressed: () async {
                    await controller.createEntry(mood: selectedMood, note: noteController.text);
                    if (Get.isBottomSheetOpen ?? false) Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.large),
    );
    noteController.dispose();
  }
}
