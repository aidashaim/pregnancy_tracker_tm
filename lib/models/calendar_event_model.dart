import 'dart:developer';
import 'calendar_event_type_model.dart';

class CalendarEventModel {
  late CalendarEventTypeModel eventType;
  late String jsonEvent;
  late int timeInt;
  String? title;

  CalendarEventModel({this.title, required this.eventType, required this.jsonEvent, required this.timeInt});

  CalendarEventModel.fromJSON(Map<String, dynamic> json) {
    try {
      eventType = CalendarEventTypeModel.getByName(json['eventType']);
      jsonEvent = json['jsonEvent'] as String;
      title = json['title'] as String?;
      timeInt = json['timeInt'] as int;
    } catch (e) {
      log('calendar_event_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'eventType': eventType.stringCode,
        'jsonEvent': jsonEvent,
        'title': title,
        'timeInt': timeInt,
      };
}
