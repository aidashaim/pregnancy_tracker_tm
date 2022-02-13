import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/size_model.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/tummy_size_model.dart';
import 'package:pregnancy_tracker_tm/repositories/tummy_size_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class TummySizeController extends GetxController {
  final RxList<TummySizeModel> sizes = tummySizeRepository.sizes.obs;
  final TextEditingController sizeTextController = TextEditingController();
  final TextEditingController dateTextController = TextEditingController();
  RxInt currentSizeInt = 0.obs;
  RxString startSize = '-'.obs;
  RxString currentSize = '-'.obs;
  RxString totalIncrease = '-'.obs;
  double? firstSize;
  DateTime? selectedDay;
  late SizeUnit currentSizeUnit;

  @override
  void onInit() {
    SizeModel? _startSize = userRepository.currentUser.tummySizeBeforePregnancy;
    SizeModel? _currentSize = userRepository.currentUser.tummySizeCurrent;
    currentSizeUnit = _currentSize?.units ?? userRepository.currentUser.sizeUnits ?? SizeUnit.centimeter;
    if (_startSize != null) {
      firstSize = _startSize.tummySize;
      startSize.value = '${_startSize.tummySize.toStringAsFixed(2)} ${_startSize.units.getShortRusName()}';
    }
    if (_currentSize != null) {
      currentSizeInt.value = _currentSize.tummySize.toInt();
      currentSize.value = '${_currentSize.tummySize.toStringAsFixed(2)} ${_currentSize.units.getShortRusName()}';
    }
    if (_currentSize != null && _startSize != null) {
      if (_currentSize.tummySize < _startSize.tummySize) {
        totalIncrease.value = '-';
      } else {
        totalIncrease.value = '';
      }
      totalIncrease.value += '${(_currentSize.tummySize - _startSize.tummySize).toStringAsFixed(2)} ${_startSize.units.getShortRusName()}';
    }
    super.onInit();
  }

  Future<void> addSize() async {
    selectedDay = DateTime.now();
    dateTextController.text = UtilFormatters.date(DateTime.now());
    bool isAdd = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(
                  hint: 'Обхват',
                  withBorder: true,
                  controller: sizeTextController,
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
    if (isAdd && sizeTextController.text.isNotEmpty && selectedDay != null) {
      final double size = double.parse(sizeTextController.text);
      final int days = userRepository.getPregnancyDays(selectedDay!);
      await tummySizeRepository.addTummySize(
        size: TummySizeModel(
          date: UtilFormatters.date(selectedDay!),
          term: UtilFormatters.gestationalAge(
            term: days,
            short: true,
          ),
          unit: currentSizeUnit,
          girth: double.parse(sizeTextController.text),
          increase: userRepository.currentUser.tummySizeBeforePregnancy != null
              ? size - userRepository.currentUser.tummySizeBeforePregnancy!.tummySize
              : 0,
          days: days.toDouble(),
          size: double.parse(sizeTextController.text),
        ),
      );
      sizes.value = tummySizeRepository.sizes;
      if (sizes.last.days == days) {
        currentSize.value = '${sizeTextController.text} ${currentSizeUnit.getShortRusName()}';
        currentSizeInt.value = double.parse(sizeTextController.text).toInt();
        userRepository.setCurrentUser(userRepository.currentUser.copyWith(
            tummySizeCurrent: SizeModel(tummySize: double.parse(sizeTextController.text), units: currentSizeUnit)));
      }
      sizes.refresh();
    }
    sizeTextController.text = '';
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
