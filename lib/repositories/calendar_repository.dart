import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_model.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_type_model.dart';
import 'package:pregnancy_tracker_tm/models/day_model.dart';
import 'package:pregnancy_tracker_tm/models/medicament_model.dart';
import 'package:pregnancy_tracker_tm/models/note_and_doctor_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/services/notification_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class CalendarRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<DayModel> days = [];

  void onInit() {
    //_storage.box.remove(UtilStorage.daysItems);
    Future.wait([getDays()]);
  }

  Future<void> addEvent({required DateTime date, required CalendarEventModel event}) async {
    int dayIndex = 0;
    DayModel? day = days.firstWhereOrNull((e) => UtilFormatters.date(e.date) == UtilFormatters.date(date));
    if (day != null) {
      int index = dayIndex = days.indexOf(day);
      day.events.add(event);
      days[index] = day;
    } else {
      days.add(DayModel(events: [event], date: date));
      dayIndex = days.length - 1;
    }
    int eventIndex = dayIndex * 10 + days[dayIndex].events.indexOf(event);

    if (event.eventType == CalendarEventTypeModel.medicament) {
      MedicamentModel medicament = MedicamentModel.fromJSON(json.decode(event.jsonEvent));
      if (medicament.needNotification) {
        for (var time in medicament.times) {
          DateTime _date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
          NotificationService().showScheduled(
            eventIndex + time.hour,
            'Приём медикаментов',
            medicament.name + ' ${UtilFormatters.dateWithTime(_date)}',
            _date,
            'date ${_date.toString()}',
          );
        }
      }
    }
    if (event.eventType == CalendarEventTypeModel.doctor) {
      NoteAndDoctorModel doctor = NoteAndDoctorModel.fromJSON(json.decode(event.jsonEvent));
      if (doctor.needNotification) {
        for (var time in doctor.times) {
          int _days = time.inMinutes ~/ 1440;
          int _hours = (time.inMinutes - _days * 1440) ~/ 60;
          int _minutes = (time.inMinutes - _days * 1440 - _hours * 60) % 60;
          NotificationService().showScheduled(
            eventIndex,
            'Приём к врачу',
            doctor.text + ' ${UtilFormatters.dateWithTime(doctor.date)}',
            DateTime(
              doctor.date.year,
              doctor.date.month,
              doctor.date.day + _days,
              doctor.date.hour + _hours,
              doctor.date.minute + _minutes,
            ),
            'date ${doctor.date.toString()}',
          );
        }
      }
    }
    if (event.eventType == CalendarEventTypeModel.note) {
      NoteAndDoctorModel note = NoteAndDoctorModel.fromJSON(json.decode(event.jsonEvent));
      // NotificationService().showScheduled(
      //   eventIndex,
      //   'Не забудьте!',
      //   note.text + ' ${UtilFormatters.dateWithTime(DateTime.now().add(Duration(seconds: 10)))}',
      //   DateTime.now().add(Duration(seconds: 10)),
      //   'date ${DateTime.now().add(Duration(seconds: 10)).toString()}',
      // );
      if (note.needNotification) {
        for (var time in note.times) {
          int _days = time.inMinutes ~/ 1440;
          int _hours = (time.inMinutes - _days * 1440) ~/ 60;
          int _minutes = (time.inMinutes - _days * 1440 - _hours * 60) % 60;
          NotificationService().showScheduled(
            eventIndex,
            'Не забудьте!',
            note.text + ' ${UtilFormatters.dateWithTime(note.date)}',
            DateTime(
              note.date.year,
              note.date.month,
              note.date.day + _days,
              note.date.hour + _hours,
              note.date.minute + _minutes,
            ),
            'date ${note.date.toString()}',
          );
        }
      }
    }

    await _storage.box.write(UtilStorage.daysItems, days.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> editEvent({
    required DateTime date,
    required DateTime newDate,
    required CalendarEventModel event,
    required CalendarEventModel newEvent,
  }) async {
    int dayIndex = days.indexWhere((e) => UtilFormatters.date(e.date) == UtilFormatters.date(date));
    int index = days[dayIndex].events.indexOf(event);
    days[dayIndex].events.removeAt(index);
    await addEvent(date: newDate, event: newEvent);
  }

  Future<void> removeEvent({
    required DateTime date,
    required CalendarEventModel event,
  }) async {
    int dayIndex = days.indexWhere((e) => UtilFormatters.date(e.date) == UtilFormatters.date(date));
    int index = days[dayIndex].events.indexWhere((e) => e.title == event.title);
    days[dayIndex].events.removeAt(index);
    await _storage.box.write(UtilStorage.daysItems, days.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getDays() async {
    final List dayItems = _storage.box.read(UtilStorage.daysItems) as List? ?? [];
    days.clear();
    await Future.forEach(dayItems, (item) {
      days.add(DayModel.fromJSON(json.decode(item as String)));
    });
    await _storage.box.write(UtilStorage.daysItems, days.map((e) => json.encode(e.toJSON())).toList());
  }
}

CalendarRepository calendarRepository = CalendarRepository();
