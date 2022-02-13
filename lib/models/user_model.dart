import 'dart:developer';
import 'package:pregnancy_tracker_tm/models/size_model.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/weight_model.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';

class UserModel {
  late int gestationalAge;
  late int currentWeek;
  late DateTime dateOfBirth;
  late bool isPro;
  WeightModel? weightBeforePregnancy;
  WeightModel? weightCurrent;
  SizeModel? tummySizeBeforePregnancy;
  SizeModel? tummySizeCurrent;
  WeightUnit? weightUnits;
  SizeUnit? sizeUnits;

  UserModel({
    required this.gestationalAge,
    required this.currentWeek,
    required this.dateOfBirth,
    required this.isPro,
    this.weightBeforePregnancy,
    this.weightCurrent,
    this.tummySizeBeforePregnancy,
    this.tummySizeCurrent,
    this.weightUnits,
    this.sizeUnits,
  });

  UserModel.fromJSON(Map<String, dynamic> json) {
    try {
      gestationalAge = json['gestationalAge'] as int;
      currentWeek = json['currentWeek'] as int;
      dateOfBirth = DateTime.parse(json['dateOfBirth'] as String);
      weightBeforePregnancy =
          json['weightBeforePregnancy'] != null ? WeightModel.fromJSON(json['weightBeforePregnancy']) : null;
      weightCurrent = json['weightCurrent'] != null ? WeightModel.fromJSON(json['weightCurrent']) : null;
      tummySizeBeforePregnancy =
          json['tummySizeBeforePregnancy'] != null ? SizeModel.fromJSON(json['tummySizeBeforePregnancy']) : null;
      tummySizeCurrent = json['tummySizeCurrent'] != null ? SizeModel.fromJSON(json['tummySizeCurrent']) : null;
      weightUnits = WeightUnit.getByName(json['weightUnits'] as String? ?? WeightUnit.kilogram.stringCode);
      sizeUnits = SizeUnit.getByName(json['sizeUnits'] as String? ?? SizeUnit.centimeter.stringCode);
      isPro = json['isPro'] as bool;
    } catch (e) {
      log('user_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'gestationalAge': gestationalAge,
        'currentWeek': currentWeek,
        'dateOfBirth': dateOfBirth.toString(),
        'weightBeforePregnancy': weightBeforePregnancy?.toJSON(),
        'weightCurrent': weightCurrent?.toJSON(),
        'tummySizeBeforePregnancy': tummySizeBeforePregnancy?.toJSON(),
        'tummySizeCurrent': tummySizeCurrent?.toJSON(),
        'weightUnits': weightUnits?.stringCode,
        'sizeUnits': sizeUnits?.stringCode,
        'isPro': isPro,
      };

  UserModel copyWith({
    int? gestationalAge,
    int? currentWeek,
    DateTime? dateOfBirth,
    WeightModel? weightBeforePregnancy,
    WeightModel? weightCurrent,
    SizeModel? tummySizeBeforePregnancy,
    SizeModel? tummySizeCurrent,
    WeightUnit? weightUnits,
    SizeUnit? sizeUnits,
    bool? isPro,
  }) =>
      UserModel(
        gestationalAge: gestationalAge ?? this.gestationalAge,
        currentWeek: currentWeek ?? this.currentWeek,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        weightBeforePregnancy: weightBeforePregnancy ?? this.weightBeforePregnancy,
        weightCurrent: weightCurrent ?? this.weightCurrent,
        tummySizeBeforePregnancy: tummySizeBeforePregnancy ?? this.tummySizeBeforePregnancy,
        tummySizeCurrent: tummySizeCurrent ?? this.tummySizeCurrent,
        weightUnits: weightUnits ?? this.weightUnits,
        sizeUnits: sizeUnits ?? this.sizeUnits,
        isPro: isPro ?? false,
      );
}
