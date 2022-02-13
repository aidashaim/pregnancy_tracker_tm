import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class IGabeBirthController extends GetxController {
  final RxString selectedTummySizeUnits = 'Сантиметры'.obs;
  final RxString selectedWeightUnits = 'Килограммы'.obs;
  final RxBool isFirstScreen = true.obs;
  final TextEditingController weightBeforeTextController = TextEditingController();
  final TextEditingController weightCurrentTextController = TextEditingController();
  final TextEditingController heightBeforeTextController = TextEditingController();
  final TextEditingController heightCurrentTextController = TextEditingController();

  @override
  void onInit() {
    weightBeforeTextController.addListener(() => isButtonActive);
    weightCurrentTextController.addListener(() => isButtonActive);
    heightBeforeTextController.addListener(() => isButtonActive);
    heightCurrentTextController.addListener(() => isButtonActive);
    super.onInit();
  }

  void skip() => isFirstScreen.value ? isFirstScreen.value = false : Get.offAllNamed(UtilRoutes.main);

  bool isButtonActive() => isFirstScreen.value
      ? weightBeforeTextController.text.isNotEmpty && weightCurrentTextController.text.isNotEmpty
      : heightBeforeTextController.text.isNotEmpty && heightCurrentTextController.text.isNotEmpty;
}
