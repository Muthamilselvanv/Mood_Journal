import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/services/image_picker_service.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/weather_model.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/activity_model.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_select_model.dart';

class HomeController extends GetxController {
  final moods = <MoodModel>[
    const MoodModel(
      emoji: "😊",
      title: "Happy",
      message: "Keep smiling! Today is full of possibilities.",
      color: AppColors.moodHappy,
    ),
    const MoodModel(
      emoji: "😌",
      title: "Calm",
      message: "Take it slow and enjoy the peaceful moments.",
      color: AppColors.moodCalm,
    ),
    const MoodModel(
      emoji: "😐",
      title: "Neutral",
      message: "Every day is a new opportunity.",
      color: AppColors.moodNeutral,
    ),
    const MoodModel(
      emoji: "😔",
      title: "Sad",
      message: "It's okay to have difficult days. Better moments will come.",
      color: AppColors.moodSad,
    ),
    const MoodModel(
      emoji: "😡",
      title: "Angry",
      message: "Take a deep breath. Tomorrow is a fresh start.",
      color: AppColors.moodAngry,
    ),
  ];

  final weathers = <WeatherModel>[
    const WeatherModel(emoji: "☀️", title: "Sunny", color: AppColors.skyBlue),
    const WeatherModel(emoji: "☁️", title: "Cloudy", color: AppColors.skyBlue),
    const WeatherModel(emoji: "🌧️", title: "Rainy", color: AppColors.skyBlue),
    const WeatherModel(emoji: "❄️", title: "Snowy", color: AppColors.skyBlue),
    const WeatherModel(emoji: "🌬️", title: "Windy", color: AppColors.skyBlue),
    const WeatherModel(emoji: "⛈️", title: "Stormy", color: AppColors.skyBlue),
  ];

  final activities = <ActivityModel>[
    const ActivityModel(
      title: "Exercise",
      icon: LucideIcons.dumbbell,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Work",
      icon: LucideIcons.briefcaseBusiness,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Reading",
      icon: LucideIcons.bookOpen,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Music",
      icon: LucideIcons.music4,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Friends",
      icon: LucideIcons.users,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Family",
      icon: LucideIcons.house,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Food",
      icon: LucideIcons.utensils,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Travel",
      icon: LucideIcons.plane,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Rest",
      icon: LucideIcons.bed,
      color: AppColors.skyBlue,
    ),
    const ActivityModel(
      title: "Creative",
      icon: LucideIcons.palette,
      color: AppColors.skyBlue,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadMood();
  }

  @override
  void onClose() {
    titleController.dispose();
    notesController.dispose();
    super.onClose();
  }

  final editingEntry = Rxn<MoodEntry>();

  bool get isEditing => editingEntry.value != null;

  final isSaving = false.obs;

  final selectedIndex = (-1).obs;

  final intensity = 1.0.obs;

  final selectedWeather = 0.obs;

  final selectedActivities = <String>[].obs;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final notesController = TextEditingController();

  final selectedImage = Rx<File?>(null);

  final MoodRepository repository = Get.find<MoodRepository>();

  final latestMood = Rxn<MoodEntry>();

  MoodModel? get selectedMood {
    final index = selectedIndex.value;
    return index >= 0 && index < moods.length ? moods[index] : null;
  }

  WeatherModel get weather => weathers[selectedWeather.value];

  final MoodRepository _repository = Get.find<MoodRepository>();

  Future<void> saveMood() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      Get.snackbar("Error", "Please login first");
      return;
    }

    final entry = MoodEntry(
      // MoodEntry.userId is int for SQLite.
      // Firebase UID is handled by MoodFirebaseDataSource.
      userId: 0,

      mood: selectedMood?.title ?? '',

      weather: weather.title,

      activities: selectedActivities.toList(),

      intensity: intensity.value.toInt(),

      title: titleController.text.trim(),

      notes: notesController.text.trim(),

      createdAt: DateTime.now(),

      imageUrl: null,
    );

    try {
      await _repository.addMoodEntry(entry);

      Get.snackbar("Success", "Mood saved successfully");
    } catch (_) {
      Get.snackbar("Error", "Failed to save mood");
    }
  }

  Future<void> loadMood() async {
    final moods = await repository.getAllMoods();

    if (moods.isNotEmpty) {
      latestMood.value = moods.first;
    } else {
      latestMood.value = null;
    }
  }

  void selectMood(int index) {
    selectedIndex.value = index;
  }

  void changeIntensity(double value) {
    intensity.value = value;
  }

  void changeWeather(int index) {
    selectedWeather.value = index;
  }

  void toggleActivity(String activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else {
      selectedActivities.add(activity);
    }
  }

  bool isActivitySelected(String activity) {
    return selectedActivities.contains(activity);
  }

  void loadMoodForEdit(MoodEntry entry) {
    editingEntry.value = entry;

    selectedIndex.value = moods.indexWhere((e) => e.title == entry.mood);

    selectedWeather.value = weathers.indexWhere(
      (e) => e.title == entry.weather,
    );

    selectedActivities.assignAll(entry.activities);

    intensity.value = entry.intensity.toDouble();

    titleController.text = entry.title;
    notesController.text = entry.notes;

    if (entry.imageUrl != null) {
      selectedImage.value = File(entry.imageUrl!);
    }
  }

  void resetForm() {
    editingEntry.value = null;

    titleController.clear();
    notesController.clear();

    selectedIndex.value = -1;
    selectedWeather.value = 0;

    selectedActivities.clear();

    intensity.value = 1;

    selectedImage.value = null;
  }

  void startNewEntry() {
    editingEntry.value = null;
    titleController.clear();
    notesController.clear();
    selectedWeather.value = 0;
    selectedActivities.clear();
    intensity.value = 1;
    selectedImage.value = null;
  }

  Future<void> takePhoto() async {
    final image = await ImagePickerService.pickFromCamera();

    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> pickPhoto() async {
    final image = await ImagePickerService.pickFromGallery();

    if (image != null) {
      selectedImage.value = image;
    }
  }

  void removePhoto() {
    selectedImage.value = null;
  }

  String get snapshotTitle {
    if (latestMood.value == null) {
      return "TODAY'S SNAPSHOT";
    }

    final now = DateTime.now();
    final moodDate = latestMood.value!.createdAt;

    final today = DateTime(now.year, now.month, now.day);
    final entryDay = DateTime(moodDate.year, moodDate.month, moodDate.day);

    if (entryDay == today) {
      return "TODAY'S SNAPSHOT";
    }

    if (entryDay == today.subtract(const Duration(days: 1))) {
      return "YESTERDAY'S SNAPSHOT";
    }

    return "LAST SNAPSHOT";
  }
}
