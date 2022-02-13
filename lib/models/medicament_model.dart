import 'dart:developer';
import 'package:flutter/material.dart';

class MedicamentModel {
  late String name;
  late String type;
  late String dosage;
  late int count;
  late String period;
  late String diet;
  late int duration;
  late DateTime dateStart;
  late List<TimeOfDay> times;
  late bool needNotification;
  late List<DateTime> dates;

  MedicamentModel({
    required this.name,
    required this.type,
    required this.dosage,
    required this.count,
    required this.period,
    required this.diet,
    required this.duration,
    required this.dateStart,
    required this.times,
    required this.needNotification,
    required this.dates,
  });

  MedicamentModel.fromJSON(Map<String, dynamic> json) {
    try {
      name = json['name'] as String;
      type = json['type'] as String;
      dosage = json['dosage'] as String;
      count = json['count'] as int;
      period = json['period'] as String;
      diet = json['diet'] as String;
      duration = json['duration'] as int;
      dateStart = DateTime.parse(json['dateStart'] as String);
      times = json['times'] != null
          ? (json['times'] as List).map((e) => TimeOfDay.fromDateTime(DateTime.parse(e))).toList()
          : [];
      needNotification = json['needNotification'] as bool;
      dates = json['dates'] != null ? (json['dates'] as List).map((e) => DateTime.parse(e)).toList() : [];
    } catch (e) {
      log('medicament_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'name': name,
        'type': type,
        'dosage': dosage,
        'count': count,
        'period': period,
        'diet': diet,
        'duration': duration,
        'dateStart': dateStart.toString(),
        'times': times.map((e) => DateTime(1, 1, 1, e.hour, e.minute).toString()).toList(),
        'needNotification': needNotification,
        'dates': dates.map((e) => e.toString()).toList(),
      };
}
