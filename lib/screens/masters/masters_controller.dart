import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/services/interstitial_ad_service.dart';
import 'package:pregnancy_tracker_tm/widgets/grid_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class MastersController extends GetxController {
  final RxString gestationalAge = ''.obs;
  final TextEditingController gestationalAgeTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final RxBool sendNotifications = true.obs;

  List<GridItem> mastersItems = [
    GridItem(
      title: 'Что можно и нельзя',
      onTap: () => goToMaster(UtilRoutes.canOrCant),
      icon: UtilIcons.mastersPermitted,
    ),
    GridItem(title: 'Мой вес', onTap: () => goToMaster(UtilRoutes.myWeight), icon: UtilIcons.mastersMyWeight),
    GridItem(title: 'Размер животика', onTap: () => goToMaster(UtilRoutes.tummySize), icon: UtilIcons.mastersTummySize),
    GridItem(
      title: 'Счетчик шевелений',
      onTap: () => goToMaster(UtilRoutes.movementCounter),
      icon: UtilIcons.mastersStirring,
    ),
    GridItem(
      title: 'Таймер схваток',
      onTap: () => goToMaster(UtilRoutes.contractionCounter),
      icon: UtilIcons.mastersContractionTimer,
    ),
    GridItem(title: 'Выбор имени', onTap: () => goToMaster(UtilRoutes.chooseName), icon: UtilIcons.mastersName),
    GridItem(
        title: 'Список покупок', onTap: () => goToMaster(UtilRoutes.shoppingList), icon: UtilIcons.mastersShopping),
    GridItem(
        title: 'Сумка в роддом', onTap: () => goToMaster(UtilRoutes.hospitalBag), icon: UtilIcons.mastersHospitalBag),
  ];

  static Future<void> goToMaster(String route) async {
    if (!userRepository.currentUser.isPro) InterstitialAdService.showInterstitialAd(2);
    Get.toNamed(route);
  }
}
