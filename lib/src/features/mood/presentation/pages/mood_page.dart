import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/mood/presentation/controllers/mood_controller.dart';

class MoodPage extends GetView<MoodController> {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood entries')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value != null) {
          return Center(child: Text(controller.errorMessage.value!));
        }
        if (controller.entries.isEmpty) {
          return const Center(child: Text('No mood entries yet.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.entries.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, index) {
            final entry = controller.entries[index];
            return ListTile(
              title: Text(entry.mood),
              subtitle: Text(entry.note.isEmpty ? 'No note' : entry.note),
              trailing: Text('${entry.createdAt.day}/${entry.createdAt.month}'),
            );
          },
        );
      }),
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
                Text('How are you feeling?', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedMood,
                  items: const ['Happy', 'Calm', 'Sad', 'Stressed', 'Angry']
                      .map((mood) => DropdownMenuItem(value: mood, child: Text(mood)))
                      .toList(),
                  onChanged: (value) => setSheetState(() => selectedMood = value ?? selectedMood),
                ),
                const SizedBox(height: 12),
                TextField(controller: noteController, decoration: const InputDecoration(labelText: 'Note (optional)')),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    await controller.createEntry(mood: selectedMood, note: noteController.text);
                    if (Get.isBottomSheetOpen ?? false) Get.back();
                  },
                  child: const Text('Save entry'),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
    noteController.dispose();
  }
}
