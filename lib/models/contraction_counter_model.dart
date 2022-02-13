import 'dart:developer';

class ContractionCounterModel {
  late String start;
  late String end;
  late String duration;
  late String interval;

  ContractionCounterModel({required this.start, required this.end, required this.duration, required this.interval});

  ContractionCounterModel.fromJSON(Map<String, dynamic> json) {
    try {
      start = json['start'] as String;
      end = json['end'] as String;
      duration = json['duration'] as String;
      interval = json['interval'] as String;
    } catch (e) {
      log('contraction_counter_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {'start': start, 'end': end, 'duration': duration, 'interval': interval};
}
