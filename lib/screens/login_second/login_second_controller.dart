import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/size_model.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class LoginSecondController extends GetxController {
  final RxString selectedSizeUnits = SizeUnit.centimeter.getRusName().obs;
  final RxString selectedWeightUnits = WeightUnit.kilogram.getRusName().obs;
  final RxBool isButtonActive = false.obs;
  final RxBool isFirstScreen = true.obs;
  final TextEditingController weightBeforeTextController = TextEditingController();
  final TextEditingController weightCurrentTextController = TextEditingController();
  final TextEditingController heightBeforeTextController = TextEditingController();
  final TextEditingController heightCurrentTextController = TextEditingController();

  @override
  void onInit() {
    weightBeforeTextController.addListener(() => checkButtonActive());
    weightCurrentTextController.addListener(() => checkButtonActive());
    heightBeforeTextController.addListener(() => checkButtonActive());
    heightCurrentTextController.addListener(() => checkButtonActive());
    super.onInit();
  }

  void skip() => isFirstScreen.value ? isFirstScreen.value = false : Get.offAllNamed(UtilRoutes.main);

  Future<void> next() async {
    if (isFirstScreen.value) {
      WeightModel weightBeforePregnancy = WeightModel(
        weight: double.parse(weightBeforeTextController.text),
        units: WeightUnit.getByRus(selectedWeightUnits.value),
      );

      WeightModel weightCurrent = WeightModel(
        weight: double.parse(weightCurrentTextController.text),
        units: WeightUnit.getByRus(selectedWeightUnits.value),
      );

      userRepository.setWeightUnit(WeightUnit.getByRus(selectedWeightUnits.value));
      userRepository.setCurrentWeight(weightCurrent);
      userRepository.setWeightBeforePregnancy(weightBeforePregnancy);

      isFirstScreen.value = false;
      checkButtonActive();
    } else {
      SizeModel tummySizeBeforePregnancy = SizeModel(
        tummySize: double.parse(heightBeforeTextController.text),
        units: SizeUnit.getByRus(selectedSizeUnits.value),
      );

      SizeModel tummySizeCurrent = SizeModel(
        tummySize: double.parse(heightCurrentTextController.text),
        units: SizeUnit.getByRus(selectedSizeUnits.value),
      );

      userRepository.setTummySizeUnit(SizeUnit.getByRus(selectedSizeUnits.value));
      userRepository.setCurrentTummySize(tummySizeCurrent);
      userRepository.setTummySizeBeforePregnancy(tummySizeBeforePregnancy);
      Get.offAllNamed(UtilRoutes.main);
    }
  }

  void changeWeightUnit(String value) => selectedWeightUnits.value = value;

  void changeSizeUnit(String value) => selectedSizeUnits.value = value;

  void checkButtonActive() {
    isButtonActive.value = isFirstScreen.value
        ? weightBeforeTextController.text.isNotEmpty && weightCurrentTextController.text.isNotEmpty
        : heightBeforeTextController.text.isNotEmpty && heightCurrentTextController.text.isNotEmpty;
  }
}
