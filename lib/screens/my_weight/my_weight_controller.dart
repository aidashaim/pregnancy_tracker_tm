import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/my_weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/repositories/my_weight_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class MyWeightController extends GetxController {
  final RxList<MyWeightModel> weights = myWeightRepository.weights.obs;
  final TextEditingController weightsTextController = TextEditingController();
  final TextEditingController dateTextController = TextEditingController();
  RxInt currentWeightInt = 0.obs;
  RxString startWeight = '-'.obs;
  RxString currentWeight = '-'.obs;
  RxString totalIncrease = '-'.obs;
  double? firstWeight;
  DateTime? selectedDay;
  late WeightUnit currentWeightUnit;

  @override
  void onInit() {
    WeightModel? _startWeight = userRepository.currentUser.weightBeforePregnancy;
    WeightModel? _currentWeight = userRepository.currentUser.weightCurrent;
    currentWeightUnit = _currentWeight?.units ?? WeightUnit.kilogram;
    if (_startWeight != null) {
      firstWeight = _startWeight.weight;
      startWeight.value = '${_startWeight.weight.toStringAsFixed(2)} ${_startWeight.units.getShortRusName()}';
    }
    if (_currentWeight != null) {
      currentWeightInt.value = _currentWeight.weight.toInt();
      currentWeight.value = '${_currentWeight.weight.toStringAsFixed(2)} ${_currentWeight.units.getShortRusName()}';
    }
    if (_currentWeight != null && _startWeight != null) {
      if (_currentWeight.weight < _startWeight.weight) {
        totalIncrease.value = '-';
      } else {
        totalIncrease.value = '';
      }
      totalIncrease.value +=
          '${(_currentWeight.weight - _startWeight.weight).toStringAsFixed(2)} ${_startWeight.units.getShortRusName()}';
    }
    super.onInit();
  }

  Future<void> addWeight() async {
    selectedDay = DateTime.now();
    dateTextController.text = UtilFormatters.date(DateTime.now());
    bool isAdd = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(
                  hint: 'Вес',
                  withBorder: true,
                  controller: weightsTextController,
                  type: TextInputType.number,
                ),
                SizedBox(height: 15.w),
                InkWell(
                  onTap: () => selectDate.call(),
                  child: IgnorePointer(
                    child: AppTextField(
                      hint: 'Дата',
                      withBorder: true,
                      controller: dateTextController,
                    ),
                  ),
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isAdd && weightsTextController.text.isNotEmpty && selectedDay != null) {
      final double weight = double.parse(weightsTextController.text);
      final int days = userRepository.getPregnancyDays(selectedDay!);
      await myWeightRepository.addMyWeights(
        weight: MyWeightModel(
          date: UtilFormatters.date(selectedDay!),
          term: UtilFormatters.gestationalAge(
            term: days,
            short: true,
          ),
          unit: currentWeightUnit,
          weight: double.parse(weightsTextController.text),
          increase: userRepository.currentUser.weightBeforePregnancy != null
              ? weight - userRepository.currentUser.weightBeforePregnancy!.weight
              : 0,
          days: days.toDouble(),
          value: double.parse(weightsTextController.text),
        ),
      );
      weights.value = myWeightRepository.weights;
      if (weights.last.days == days) {
        currentWeight.value = '${weightsTextController.text} ${currentWeightUnit.getShortRusName()}';
        currentWeightInt.value = double.parse(weightsTextController.text).toInt();
        userRepository.setCurrentUser(userRepository.currentUser.copyWith(
            weightCurrent: WeightModel(weight: double.parse(weightsTextController.text), units: currentWeightUnit)));
      }
      weights.refresh();
    }
    weightsTextController.text = '';
    dateTextController.text = '';
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showCustomDatePicker();

    if (picked != null) {
      selectedDay = picked;
      dateTextController.text = UtilFormatters.date(picked);
    }
  }
}
