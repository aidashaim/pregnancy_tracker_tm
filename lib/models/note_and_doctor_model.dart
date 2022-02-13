import 'dart:developer';

class NoteAndDoctorModel {
  late DateTime date;
  late String text;
  late bool needNotification;
  late List<Duration> times;

  NoteAndDoctorModel({
    required this.date,
    required this.text,
    required this.needNotification,
    required this.times,
  });

  NoteAndDoctorModel.fromJSON(Map<String, dynamic> json) {
    try {
      date = DateTime.parse(json['date'] as String);
      text = json['text'] as String;
      needNotification = json['needNotification'] as bool;
      times = json['times'] != null
          ? (json['times'] as List)
              .map((e) => Duration(minutes: e))
              .toList() //TimeOfDay.fromDateTime(DateTime.parse(e))).toList()
          : [];
    } catch (e) {
      log('note_and_doctor_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'date': date.toString(),
        'text': text,
        'needNotification': needNotification,
        'times': times.map((e) => e.inMinutes).toList()//DateTime(1, 1, 1, e, e.minute).toString()).toList(),
      };
}
