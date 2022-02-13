import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';

class MyWeightModel {
  late String date;
  late String term;
  late double weight;
  late double increase;
  late double days;
  late double value;
  late WeightUnit unit;

  MyWeightModel({
    required this.date,
    required this.term,
    required this.weight,
    required this.increase,
    required this.days,
    required this.value,
    required this.unit,
  });

  MyWeightModel.fromJSON(Map<String, dynamic> json) {
    try {
      date = json['date'] as String;
      term = json['term'] as String;
      weight = json['weight'] as double;
      increase = json['increase'] as double;
      days = json['days'] as double;
      value = json['value'] as double;
      unit = WeightUnit.getByName(json['unit'] as String);
    } catch (e) {
      log('tummy_size_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'date': date,
        'term': term,
        'unit': unit.stringCode,
        'weight': weight,
        'days': days,
        'value': value,
        'increase': increase,
      };
}
