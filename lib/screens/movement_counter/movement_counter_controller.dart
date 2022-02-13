import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_item_model.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_model.dart';
import 'package:pregnancy_tracker_tm/repositories/movement_counter_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class MovementCounterController extends GetxController {
  RxList<MovementCounterModel> movementCounterItems = movementCounterRepository.movements.obs;
  RxString firstMovement = ''.obs;
  RxString lastMovement = ''.obs;
  RxInt movementCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    firstMovement.value = movementCounterRepository.firstMovement ?? '';
    lastMovement.value = movementCounterRepository.lastMovement ?? '';
    movementCount.value = movementCounterRepository.movementCount;
  }

  Future<void> addMovement() async {
    DateTime now = DateTime.now();

    MovementCounterModel movement = MovementCounterModel(
      date: now,
      period: 0,
      count: 1,
      days: userRepository.getPregnancyDays(now),
      items: [MovementCounterItemModel(start: TimeOfDay.fromDateTime(now), end: TimeOfDay.fromDateTime(now))],
    );
    await movementCounterRepository.addMovement(movement: movement);
    updateList();
  }

  Future<void> addCustomMovement() async {
    final result = await Get.toNamed(UtilRoutes.addMovement);
    if (result != null) {
      MovementCounterModel movement = result;
      await movementCounterRepository.addMovement(movement: movement);
      updateList();
    }
  }

  Future<void> deleteLast() async {
    await movementCounterRepository.deleteLastMovement();
    updateList();
  }

  void updateList() {
    movementCounterItems.value = movementCounterRepository.movements;
    movementCounterItems.refresh();
    firstMovement.value = movementCounterRepository.firstMovement ?? '';
    lastMovement.value = movementCounterRepository.lastMovement ?? '';
    movementCount.value = movementCounterRepository.movementCount;
  }
}
