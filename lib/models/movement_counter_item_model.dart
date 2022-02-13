import 'dart:developer';

import 'package:flutter/material.dart';

class MovementCounterItemModel {
  late TimeOfDay start;
  late TimeOfDay end;

  MovementCounterItemModel({
    required this.start,
    required this.end,
  });

  MovementCounterItemModel.fromJSON(Map<String, dynamic> json) {
    try {
      start = TimeOfDay.fromDateTime(DateTime.parse(json['start'] as String));
      end = TimeOfDay.fromDateTime(DateTime.parse(json['end'] as String));
    } catch (e) {
      log('movement_counter_item_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'start': DateTime(0, 0, 0, start.hour, start.minute, 0).toString(),
        'end': DateTime(0, 0, 0, end.hour, end.minute, 0).toString(),
      };
}
