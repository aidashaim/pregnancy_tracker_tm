import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class CalendarEventTypeModel {
  String stringCode;

  CalendarEventTypeModel(this.stringCode);

  CalendarEventTypeModel._(this.stringCode);

  static final CalendarEventTypeModel note = CalendarEventTypeModel._('NOTE');
  static final CalendarEventTypeModel mood = CalendarEventTypeModel._('MOOD');
  static final CalendarEventTypeModel medicament = CalendarEventTypeModel._('MEDICAMENT');
  static final CalendarEventTypeModel doctor = CalendarEventTypeModel._('DOCTOR');

  static final Map<String, String> mapIcons = {
    note.stringCode: UtilIcons.notes,
    mood.stringCode: UtilIcons.mood,
    medicament.stringCode: UtilIcons.pharmacy,
    doctor.stringCode: UtilIcons.pharmacy,
  };

  static final Map<String, CalendarEventTypeModel> _values = {
    note.stringCode: note,
    mood.stringCode: mood,
    medicament.stringCode: medicament,
    doctor.stringCode: doctor,
  };

  static CalendarEventTypeModel getByName(String name) {
    CalendarEventTypeModel? find;
    _values.forEach((key, value) {
      if (key == name) find = _values[key];
    });
    return find ?? CalendarEventTypeModel.note;
  }
}
