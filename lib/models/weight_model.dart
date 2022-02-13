import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';

class WeightModel {
  late double weight;
  late WeightUnit units;

  WeightModel({required this.weight, required this.units});

  WeightModel.fromJSON(Map<String, dynamic> json) {
    try {
      weight = json['weight'] as double;
      units = WeightUnit.getByName(json['units'] as String);
    } catch (e) {
      log('weight_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'weight': weight,
        'units': units.stringCode,
      };
}
