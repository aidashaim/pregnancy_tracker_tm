import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/user_model.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/services/notification_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class LoginController extends GetxController {
  final RxString selectedTiming = 'Предполагаемая дата родов'.obs;
  final RxString gestationalAge = ''.obs;
  final TextEditingController gestationalAgeTextController = TextEditingController();
  DateTime? selectedDate;
  DateTime? _dateOfBirth;
  late int _daysCount;

  List<String> timingValues = ['Предполагаемая дата родов', 'Дата последней менструации', 'Дата зачатия'];

  void changeTiming(String value) {
    if ((selectedTiming.value == 'Предполагаемая дата родов' && value != 'Предполагаемая дата родов') ||
        (selectedTiming.value != 'Предполагаемая дата родов' && value == 'Предполагаемая дата родов')) {
      gestationalAgeTextController.text = '';
      gestationalAge.value = '';
      selectedDate = null;
    }
    selectedTiming.value = value;
    calculateWeeks();
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showCustomDatePicker(
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: selectedTiming.value == 'Предполагаемая дата родов'
          ? DateTime.now()
          : DateTime.now().subtract(const Duration(days: 293)),
      lastDate: selectedTiming.value == 'Предполагаемая дата родов'
          ? DateTime.now().add(const Duration(days: 293))
          : DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      gestationalAgeTextController.text = UtilFormatters.date(selectedDate!);
      calculateWeeks();
    }
  }

  void calculateWeeks() {
    if (selectedDate != null) {
      switch (selectedTiming.value) {
        case 'Предполагаемая дата родов':
          _daysCount = UtilRepo.pregnancyDuration - selectedDate!.difference(DateTime.now()).inDays;
          _dateOfBirth = selectedDate!;
          break;
        case 'Дата последней менструации':
          _daysCount = DateTime.now().difference(selectedDate!).inDays - 7;
          _dateOfBirth = selectedDate!.add(const Duration(days: 301));
          break;
        case 'Дата зачатия':
          _daysCount = DateTime.now().difference(selectedDate!).inDays;
          _dateOfBirth = selectedDate!.add(Duration(days: UtilRepo.pregnancyDuration));
          break;
      }
      if (_daysCount < 7) {
        gestationalAge.value = 'Вы беременны ${UtilFormatters.gestationalAge(term: _daysCount, withWeeks: false)}';
      } else {
        gestationalAge.value = 'Вы беременны ${UtilFormatters.gestationalAge(term: _daysCount, withDays: false)}';
      }
    }
  }

  Future<void> goNext() async {
    DateTime now = DateTime.now();
    DateTime nextThursday = now;
    DateTime nextMonday = now;
    DateTime nextDay = now;

    while (nextThursday.weekday != 4) {
      nextThursday = nextThursday.add(const Duration(days: 1));
    }
    while (nextMonday.weekday != 1) {
      nextMonday = nextMonday.add(const Duration(days: 1));
    }
    nextDay = now.hour < 11 ? now : now.add(const Duration(days: 1));

    await userRepository.setCurrentUser(
      UserModel(dateOfBirth: _dateOfBirth!, gestationalAge: _daysCount, currentWeek: _daysCount ~/ 7),
    );

    await NotificationService().showPeriodically(
      0,
      'Доступна новая статья',
      'Спешите прочесть!',
      DateTime(nextDay.year, nextDay.month, nextDay.day, 11, 0),
      'UtilRoutes.main',
      true,
    );
    await NotificationService().showPeriodically(
      2,
      'Не забудьте взвеситься',
      'Следите за весом в динамике',
      DateTime(nextThursday.year, nextThursday.month, nextThursday.day, 10, 0),
      'UtilRoutes.myWeight',
      false,
    );

    int week = _daysCount ~/ 7;
    for (int i = week + 1; i < 42; i++) {
      DateTime _date = nextMonday.add(Duration(days: (i - week) * 7));
      bool _b = UtilRepo.babyFruit[i].contains('Меньше');
      await NotificationService().showScheduled(
        1,
        'Ваш малыш ${_b ? '' : 'как'} ${UtilRepo.babyFruit[i].toLowerCase()}',
        'Читайте новые советы на неделю',
        DateTime(_date.year, _date.month, _date.day, 10, 0),
        'UtilRoutes.main',
      );
    }

    Get.toNamed(UtilRoutes.loginSecond);
  }
}
