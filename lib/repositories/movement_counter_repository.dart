import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/movement_counter_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class MovementCounterRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<MovementCounterModel> movements = [];
  String? firstMovement;
  String? lastMovement;
  int movementCount = 0;

  int timeToSeconds(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  void onInit() {
    Future.wait([getMovements()]);
    MovementCounterModel? currentDayMovement =
        movements.firstWhereOrNull((e) => UtilFormatters.date(e.date) == UtilFormatters.date(DateTime.now()));
    if (currentDayMovement != null) {
      firstMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
          UtilFormatters.time(currentDayMovement.items.first.start);
      lastMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
          UtilFormatters.time(currentDayMovement.items.last.end);
      movementCount = currentDayMovement.count;
    }
  }

  Future<void> addMovement({required MovementCounterModel movement}) async {
    MovementCounterModel? currentDayMovement;
    if (movements.isNotEmpty) {
      currentDayMovement =
          movements.firstWhereOrNull((e) => UtilFormatters.date(e.date) == UtilFormatters.date(movement.date));
    }

    if (currentDayMovement != null) {
      int index = movements.indexOf(currentDayMovement);
      currentDayMovement.items.addAll(movement.items);
      currentDayMovement.items.sort((a, b) => timeToSeconds(a.end).compareTo(timeToSeconds(b.end)));
      currentDayMovement.count += movement.count;
      currentDayMovement.period =
          timeToSeconds(currentDayMovement.items.last.end) - timeToSeconds(currentDayMovement.items.first.start);
      movements[index] = currentDayMovement;
      firstMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
          UtilFormatters.time(currentDayMovement.items.first.start);
      lastMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
          UtilFormatters.time(currentDayMovement.items.last.end);

      if (UtilFormatters.date(DateTime.now()) == UtilFormatters.date(currentDayMovement.date)) {
        lastMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
            UtilFormatters.time(currentDayMovement.items.last.end);
        firstMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
            UtilFormatters.time(currentDayMovement.items.first.start);
        movementCount = currentDayMovement.count;
      }
    } else {
      movements.add(movement);
      movements.sort((a, b) => a.days.compareTo(b.days));
      if (UtilFormatters.date(DateTime.now()) == UtilFormatters.date(movement.date)) {
        firstMovement = UtilFormatters.shortDateMonth(movement.date) + UtilFormatters.time(movement.items.first.start);
        lastMovement = UtilFormatters.shortDateMonth(movement.date) + UtilFormatters.time(movement.items.last.end);
        movementCount = movement.count;
      }
    }
    await _storage.box.write(UtilStorage.movementItems, movements.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> deleteLastMovement() async {
    MovementCounterModel? currentDayMovement;
    if (movements.isNotEmpty) {
      currentDayMovement =
          movements.firstWhereOrNull((e) => UtilFormatters.date(e.date) == UtilFormatters.date(DateTime.now()));

      if (currentDayMovement != null) {
        int index = movements.indexOf(currentDayMovement);
        if (currentDayMovement.count == 1) {
          movements.removeAt(index);
          movementCount = 0;
          firstMovement = null;
          lastMovement = null;
        } else {
          currentDayMovement.count -= 1;
          movementCount = currentDayMovement.count;
          currentDayMovement.items.removeLast();
          currentDayMovement.period =
              timeToSeconds(currentDayMovement.items.last.end) - timeToSeconds(currentDayMovement.items.first.start);
          firstMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
              UtilFormatters.time(currentDayMovement.items.first.start);
          lastMovement = UtilFormatters.shortDateMonth(currentDayMovement.date) +
              UtilFormatters.time(currentDayMovement.items.last.end);

          movements[index] = currentDayMovement;
        }
        await _storage.box.write(UtilStorage.movementItems, movements.map((e) => json.encode(e.toJSON())).toList());
      }
    }
  }

  Future<void> getMovements() async {
    final List movementItems = _storage.box.read(UtilStorage.movementItems) as List? ?? [];
    await Future.forEach(movementItems, (item) {
      MovementCounterModel movement = MovementCounterModel.fromJSON(json.decode(item as String));
      movements.add(movement);
    });
  }
}

MovementCounterRepository movementCounterRepository = MovementCounterRepository();
