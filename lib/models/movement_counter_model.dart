import 'dart:developer';
import 'movement_counter_item_model.dart';

class MovementCounterModel {
  late DateTime date;
  late int period;
  late int count;
  late int days;
  late List<MovementCounterItemModel> items;

  MovementCounterModel({
    required this.date,
    required this.period,
    required this.count,
    required this.days,
    required this.items,
  });

  MovementCounterModel.fromJSON(Map<String, dynamic> json) {
    try {
      date = DateTime.parse(json['date'] as String);
      period = json['period'] as int;
      count = json['count'] as int;
      days = json['days'] as int;
      items = json['items'] != null
          ? (json['items'] as List).map((e) => MovementCounterItemModel.fromJSON(e)).toList()
          : [];
    } catch (e) {
      log('movement_counter_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'date': date.toString(),
        'period': period,
        'count': count,
        'days': days,
        'items': items.map((e) => e.toJSON()).toList(),
      };
}
