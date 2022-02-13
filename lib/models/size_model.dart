import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';

class SizeModel {
  late double tummySize;
  late SizeUnit units;

  SizeModel({required this.tummySize, required this.units});

  SizeModel.fromJSON(Map<String, dynamic> json) {
    try {
      tummySize = json['tummySize'] as double;
      units = SizeUnit.getByName(json['units'] as String);
    } catch (e) {
      log('tummy_size_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'tummySize': tummySize,
        'units': units.stringCode,
      };
}
