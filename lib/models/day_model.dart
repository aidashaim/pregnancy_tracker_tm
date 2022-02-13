import 'dart:developer';
import 'package:collection/src/iterable_extensions.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_type_model.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_model.dart';

class DayModel {
  late final DateTime date;
  late final List<CalendarEventModel> events;

  DayModel({required this.date, required this.events});

  DayModel.fromJSON(Map<String, dynamic> json) {
    try {
      date = DateTime.parse(json['date'] as String);
      events =
          json['events'] != null ? (json['events'] as List).map((e) => CalendarEventModel.fromJSON(e)).toList() : [];
    } catch (e) {
      log('day_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'date': date.toString(),
        'events': events.map((e) => e.toJSON()).toList(),
      };

  MoodModel? get getMood {
    CalendarEventModel? event = events.firstWhereOrNull((e) => e.eventType == CalendarEventTypeModel.mood);
    if (event != null) {
      return MoodModel.getByName(event.jsonEvent.toString());
    }
    return null;
  }
}
