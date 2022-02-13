import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/note_and_doctor_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class AddNoteAndDoctorController extends GetxController {
  final Rx<DateTime> selectedDay = DateTime.now().obs;
  final RxBool notification = false.obs;
  final RxList<Duration> selectedDurations = <Duration>[].obs;
  final RxList<String> selectedTimesTitles = <String>[].obs;
  final RxString text = ''.obs;
  final TextEditingController noteTextController = TextEditingController();
  NoteAndDoctorModel? initialEvent;
  List<String> titles = [
    'В момент начала',
    'За 5 минут',
    'За 15 минут',
    'За 30 минут',
    'За 1 час',
    'За 4 часа',
    'За 1 день',
    'За 2 дня',
    'За 1 неделю',
  ];
  List<Duration> times = [
    const Duration(),
    const Duration(minutes: 5),
    const Duration(minutes: 15),
    const Duration(minutes: 30),
    const Duration(hours: 1),
    const Duration(hours: 4),
    const Duration(days: 1),
    const Duration(days: 2),
    const Duration(days: 7),
  ];

  @override
  void onInit() {
    selectedDay.value = Get.arguments['date'];
    initialEvent = Get.arguments['event'];
    if (initialEvent != null) {
      selectedDay.value = initialEvent!.date;
      notification.value = initialEvent!.needNotification;
      noteTextController.text = text.value = initialEvent!.text;
      //selectedTimes.value = initialEvent!.times;
      loadTimes(initialEvent!.times);
    }
    noteTextController.addListener(() => text.value = noteTextController.text);
    super.onInit();
  }

  Future<void> add() async {
    NoteAndDoctorModel noteAndDoctor = NoteAndDoctorModel(
      date: selectedDay.value,
      text: noteTextController.text,
      needNotification: notification.value,
      times: selectedDurations,
    );
    Get.back(result: noteAndDoctor);
  }

  Future<void> selectTimes() async {
    Map<String, dynamic>? result =
        await Get.toNamed(UtilRoutes.selectTime, arguments: selectedDurations) as Map<String, dynamic>?;
    if (result != null) {
      List<Duration> durations = result['durations'] as List<Duration>? ?? [];
      selectedTimesTitles.value = result['times'] as List<String>? ?? [];
      selectedDurations.value = durations;
    }
  }

  Future<void> loadTimes(List<Duration> durations) async {
    if (times.isNotEmpty) {
      selectedDurations.value = durations;
      for (var duration in durations) {
        selectedTimesTitles.add(titles[times.indexOf(duration)]);
      }
    }
  }

  void changeNotification(bool value) {
    notification.value = value;
    if (!value) {
      selectedDurations.clear();
      selectedTimesTitles.clear();
    }
  }

  Future<void> editDateTime() async {
    final DateTime? pickedDate = await showCustomDatePicker();
    if (pickedDate != null) {
      selectedDay.value = pickedDate;
    }

    final TimeOfDay? pickedTime = await showCustomTimePicker();
    if (pickedTime != null) {
      selectedDay.value = DateTime(
          selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, pickedTime.hour, pickedTime.minute);
    }
  }
}
