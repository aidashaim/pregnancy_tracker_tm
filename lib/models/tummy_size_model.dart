import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';

class TummySizeModel {
  late String date;
  late String term;
  late double girth;
  late double increase;
  late double days;
  late double size;
  late SizeUnit unit;

  TummySizeModel({
    required this.date,
    required this.term,
    required this.girth,
    required this.increase,
    required this.days,
    required this.size,
    required this.unit,
  });

  TummySizeModel.fromJSON(Map<String, dynamic> json) {
    try {
      date = json['date'] as String;
      term = json['term'] as String;
      girth = json['girth'] as double;
      increase = json['increase'] as double;
      days = json['days'] as double;
      size = json['size'] as double;
      unit = SizeUnit.getByName(json['unit'] as String);
    } catch (e) {
      log('tummy_size_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'date': date,
        'term': term,
        'unit': unit.stringCode,
        'girth': girth,
        'days': days,
        'size': size,
        'increase': increase,
      };
}
