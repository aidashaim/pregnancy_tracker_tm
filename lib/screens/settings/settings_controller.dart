import 'dart:io';
import 'package:launch_review/launch_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';
import 'package:pregnancy_tracker_tm/services/purchase_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:share/share.dart';
import 'package:pregnancy_tracker_tm/models/size_model.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/services/notification_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class SettingsController extends GetxController {
  final StorageProvider _storage = Get.find<StorageProvider>();
  final RxString selectedTummySizeUnits = ''.obs;
  final RxString selectedWeightUnits = ''.obs;
  final RxBool sendNotifications = true.obs;
  final RxBool isUserPro = false.obs;
  final TextEditingController valueTextController = TextEditingController();
  DateTime? birthDate;

  @override
  void onInit() {
    super.onInit();
    isUserPro.value = PurchaseService.instance.isProUser;
    selectedTummySizeUnits.value =
        userRepository.currentUser.sizeUnits?.getRusName() ?? SizeUnit.centimeter.getRusName();
    selectedWeightUnits.value =
        userRepository.currentUser.weightUnits?.getRusName() ?? WeightUnit.kilogram.getRusName();
  }

  void goToSaved() => Get.toNamed(UtilRoutes.savedArticles);

  void goToPaywall() => Get.toNamed(UtilRoutes.paywall);

  void goToIGaveBirth() => Get.toNamed(UtilRoutes.iGaveBirth);

  Future<void> share() async {
    String appUrl = Platform.isAndroid ? UtilRepo.shareUrlAndroid : UtilRepo.shareUrlIOS;
    await Share.share(appUrl);
  }

  void rateApp() {
    if (Platform.isAndroid) {
      LaunchReview.launch(androidAppId: "com.pregnancytracker.tm");
    } else {
      LaunchReview.launch(iOSAppId: "1610942708");
    }
  }

  Future<void> selectSizeUnits(String value) async {
    if (selectedTummySizeUnits.value != value) {
      selectedTummySizeUnits.value = value;
      await userRepository.setTummySizeUnit(SizeUnit.getByRus(value));
    }
  }

  Future<void> selectWeightUnits(String value) async {
    if (selectedWeightUnits.value != value) {
      selectedWeightUnits.value = value;
      await userRepository.setWeightUnit(WeightUnit.getByRus(value));
    }
  }

  Future<void> nullifyApp() async {
    bool isNullify = await Get.dialog<bool>(
          const AppDialog(
            title: 'Обнулить приложение',
            confirmButtonTitle: 'Продолжить',
            description: 'Все внесенные данные и записи будут удалены. Вы уверены?',
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isNullify) {
      _storage.box.erase();
      _storage.box.write(UtilStorage.firstRun, true);
      NotificationService().cancelAll();
      PurchaseService.instance.isProUser = false;
      Get.offAllNamed(UtilRoutes.login);
    }
  }

  Future<void> enterWeightBeforePregnancy() async {
    bool result = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить вес до беременности',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(
                  hint: 'Вес',
                  withBorder: true,
                  controller: valueTextController,
                  type: TextInputType.number,
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;

    if (result && valueTextController.text.isNotEmpty) {
      await userRepository.setCurrentUser(
        userRepository.currentUser.copyWith(
          weightBeforePregnancy: WeightModel(
            weight: double.parse(valueTextController.text),
            units: WeightUnit.getByRus(selectedWeightUnits.value),
          ),
        ),
      );
    }
    valueTextController.text = '';
  }

  Future<void> enterSizeBeforePregnancy() async {
    bool result = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить объем живота до беременности',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(
                  hint: 'Объем живота',
                  withBorder: true,
                  controller: valueTextController,
                  type: TextInputType.number,
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;

    if (result && valueTextController.text.isNotEmpty) {
      await userRepository.setTummySizeBeforePregnancy(
        SizeModel(
          tummySize: double.parse(valueTextController.text),
          units: SizeUnit.getByRus(selectedTummySizeUnits.value),
        ),
      );
    }
    valueTextController.text = '';
  }

  Future<void> enterDateOfBirth() async {
    bool result = await Get.dialog<bool>(
          AppDialog(
            title: 'Указать срок беременности',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: selectDate,
                  child: IgnorePointer(
                    ignoring: true,
                    child: AppTextField(hint: 'Срок', controller: valueTextController, withBorder: true),
                  ),
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;

    if (result && birthDate != null) {
      await userRepository.setDateOfBirth(birthDate!);
    }
    valueTextController.text = '';
    Get.find<HomeController>().onInit();
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showCustomDatePicker(firstDate: DateTime.now());

    if (picked != null) {
      birthDate = picked;
      valueTextController.text = UtilFormatters.date(picked);
    }
  }
}
