import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/services/permission_service.dart';
import 'package:mood_journal_app/src/core/services/image_picker_service.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
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

  Future<void> loadMood() async {
    final repository = Get.find<MoodRepository>();

    final moods = await repository.getAllMoods();

    print("Total entries: ${moods.length}");
  }

  final selectedIndex = 0.obs;

  final intensity = 1.0.obs;

  final selectedWeather = 0.obs;

  final selectedActivities = <String>[].obs;
  
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final notesController = TextEditingController();

  final selectedImage = Rx<File?>(null);

  @override
  void onClose() {
    titleController.dispose();
    notesController.dispose();
    super.onClose();
  }

  MoodModel get selectedMood => moods[selectedIndex.value];

  WeatherModel get weather => weathers[selectedWeather.value];

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

  void resetForm() {
    titleController.clear();
    notesController.clear();

    selectMood(0);
    selectedWeather(0);

    selectedActivities.clear();

    intensity.value = 5;
    selectedImage.value = null;
  }

  Future<void> takePhoto() async {
    final granted = await PermissionService.requestCameraPermission();

    if (!granted) return;

    final image = await ImagePickerService.pickFromCamera();

    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> pickPhoto() async {
    final granted = await PermissionService.requestGalleryPermission();

    if (!granted) return;

    final image = await ImagePickerService.pickFromGallery();

    if (image != null) {
      selectedImage.value = image;
    }
  }

  void removePhoto() {
    selectedImage.value = null;
  }
}
