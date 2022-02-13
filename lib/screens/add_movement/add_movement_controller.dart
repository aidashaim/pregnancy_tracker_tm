import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_item_model.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_model.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class AddMovementController extends GetxController {
  final Rx<DateTime> selectedDay = DateTime.now().obs;
  final Rx<TimeOfDay?> selectedTimeStart = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> selectedTimeEnd = Rx<TimeOfDay?>(null);
  final RxInt selectedCount = 1.obs;

  void increaseCount() => selectedCount.value += 1;

  void decreaseCount() => selectedCount.value > 2 ? selectedCount.value -= 1 : selectedCount.value = 1;

  int timeToSeconds(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  void addMovement() {
    DateTime date = DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 0, 0);
    int _periodSeconds = timeToSeconds(selectedTimeEnd.value!) - timeToSeconds(selectedTimeStart.value!);
    Get.back(
      result: MovementCounterModel(
        date: date,
        period: _periodSeconds,
        count: selectedCount.value,
        days: userRepository.getPregnancyDays(date),
        items: List<MovementCounterItemModel>.generate(
          selectedCount.value,
          (i) => MovementCounterItemModel(start: selectedTimeStart.value!, end: selectedTimeEnd.value!),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showCustomDatePicker();

    if (picked != null) {
      selectedDay.value = picked;
    }
  }

  Future<void> selectTime(bool isStart) async {
    final TimeOfDay? picked = await showCustomTimePicker();
    if (picked != null) {
      if (isStart) {
        selectedTimeStart.value = picked;
      } else {
        selectedTimeEnd.value = picked;
      }
    }
  }
}
