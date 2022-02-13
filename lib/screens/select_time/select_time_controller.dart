import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTimeController extends GetxController {
  final RxBool notification = true.obs;
  final TextEditingController noteTextController = TextEditingController();
  RxList<bool> selectValues = <bool>[false, false, false, false, false, false, false, false, false].obs;
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
    List<Duration> _durations = Get.arguments as List<Duration>;
    for(var _duration in _durations){
      selectValues[times.indexOf(_duration)] = true;
    }
    super.onInit();
  }

  void selectTime(int index) {
    selectValues[index] = !selectValues[index];
    selectValues.refresh();
  }

  void goBack() {
    List<Duration> _durations = [];
    List<String> _times = [];
    for (int i = 0; i < selectValues.length; i++) {
      if (selectValues[i]) {
        _durations.add(times[i]);
        _times.add(titles[i]);
      }
    }
    Get.back(result: {'durations': _durations, 'times': _times});
  }
}
