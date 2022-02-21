import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/user_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/services/interstitial_ad_service.dart';
import 'package:pregnancy_tracker_tm/services/purchase_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';
import 'package:pregnancy_tracker_tm/repositories/calendar_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/contraction_counter_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/hospital_bag_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/movement_counter_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/my_weight_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/name_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/shopping_list_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/tummy_size_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/weekly_advices_repository.dart';

class SplashController extends GetxController {
  final StorageProvider _storage = Get.find<StorageProvider>();

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  void loadData() async {
    nameRepository.onInit();
    hospitalBagRepository.onInit();
    shoppingListRepository.onInit();
    movementCounterRepository.onInit();
    tummySizeRepository.onInit();
    myWeightRepository.onInit();
    calendarRepository.onInit();
    dailyAdviceRepository.onInit();
    contractionCounterRepository.onInit();
    weeklyAdvicesRepository.onInit();
    final userJson = _storage.box.read(UtilStorage.currentUser);
    log('User from storage $userJson');

    if (userJson != null) {
      UserModel user = UserModel.fromJSON(userJson);
      int days = UtilRepo.pregnancyDuration - user.dateOfBirth.difference(DateTime.now()).inDays;
      user.gestationalAge = days > UtilRepo.pregnancyDuration ? UtilRepo.pregnancyDuration : days;
      user.currentWeek = user.gestationalAge ~/ 7;

      userRepository.setCurrentUser(user).then((value) async {
        await Future.delayed(const Duration(seconds: 2));
        if (!PurchaseService.instance.isProUser) InterstitialAdService.showInterstitialAd(0);
        PurchaseService.instance.isOnInit = false;
        Get.offAllNamed(UtilRoutes.main);
      });
    } else {
      Get.offAllNamed(UtilRoutes.login);
    }
  }
}
