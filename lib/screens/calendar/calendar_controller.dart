import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_type_model.dart';
import 'package:pregnancy_tracker_tm/models/day_model.dart';
import 'package:pregnancy_tracker_tm/models/medicament_model.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/models/note_and_doctor_model.dart';
import 'package:pregnancy_tracker_tm/repositories/calendar_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_model.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/widgets/add_action_dialog.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/widgets/choose_mood_dialog.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class CalendarController extends GetxController {
  final RxList<CalendarEventModel> selectedEvents = <CalendarEventModel>[].obs;
  final Rx<MoodModel?> selectedDayMood = Rx<MoodModel?>(null);
  RxList<DayModel> dayItems = calendarRepository.days.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxInt weekInMonthCount = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt weeks = 0.obs;
  late int currentWeek;
  late DateTime firstDay;
  late DateTime lastDay;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    firstDay = now.subtract(Duration(days: UtilRepo.pregnancyDuration));
    lastDay = now.add(Duration(days: UtilRepo.pregnancyDuration));
    currentWeek = (userRepository.getPregnancyDays(DateTime.now())) ~/ 7;
    monthChanged(selectedDate.value);
    selectedEvents.value = getEventsForDay(selectedDate.value)..sort((a, b) => a.timeInt.compareTo(b.timeInt));
    isLoading.value = false;
  }

  Future<int> getWeeksCountInMonth(DateTime date) async {
    var wDay = DateTime(date.year, date.month, 1).weekday;
    int daysInMonth = DateTime(date.year, date.month + 1).difference(DateTime(date.year, date.month)).inDays;
    int res = 0;
    int dayOfWeekday = 1;
    while (dayOfWeekday <= daysInMonth) {
      res++;
      dayOfWeekday += 7;
    }
    if (wDay + daysInMonth - dayOfWeekday + 7 > 7) res++;
    return res;
  }

  List<CalendarEventModel> getEventsForDay(DateTime? date) {
    if (date != null) {
      DayModel? day = getDayFromStorage(date);
      if (day != null) {
        return day.events;
      }
    }
    return [];
  }

  DayModel? getDayFromStorage(DateTime date) {
    if (dayItems.isNotEmpty) {
      return dayItems.firstWhereOrNull((day) => UtilFormatters.date(day.date) == UtilFormatters.date(date));
    }
    return null;
  }

  void onDaySelected(DateTime _selectedDay, DateTime _focusedDay) {
    DayModel? day = getDayFromStorage(_selectedDay);
    selectedDate.value = focusedDay.value = _focusedDay;
    if (day != null) {
      selectedEvents.value = day.events;
      selectedDayMood.value = day.getMood;
    } else {
      selectedEvents.value = [];
      selectedDayMood.value = null;
    }
    update(['calendar']);
  }

  Future<void> monthChanged(DateTime _focusedDay) async {
    focusedDay.value = selectedDate.value = _focusedDay;
    int difference = DateTime(selectedDate.value.year, selectedDate.value.month, 1).difference(DateTime.now()).inDays;
    weeks.value = currentWeek + (difference + 6) ~/ 7;
    weekInMonthCount.value = await getWeeksCountInMonth(_focusedDay);
    onDaySelected(_focusedDay, _focusedDay);
  }

  Future<void> addAction() async {
    String? action = await Get.dialog<String>(const AddActionDialog(), barrierDismissible: false);
    switch (action) {
      case 'Заметка':
        addNoteAndDoctor(false);
        break;
      case 'Приём к врачу':
        addNoteAndDoctor(true);
        break;
      case 'Приём медикаментов':
        addMedicament();
        break;
      case 'Настроение':
        chooseMood();
        break;
      default:
        break;
    }
  }

  Future<void> chooseMood() async {
    MoodModel? mood = await Get.dialog<MoodModel>(const ChooseMoodDialog(), barrierDismissible: false);
    if (mood != null) {
      await calendarRepository.addEvent(
        date: selectedDate.value,
        event: CalendarEventModel(
          eventType: CalendarEventTypeModel.mood,
          jsonEvent: mood.stringCode,
          timeInt: selectedDate.value.hour * 60 + selectedDate.value.minute,
        ),
      );
      updateList();
    }
  }

  Future<void> addNoteAndDoctor(bool isDoctor, {CalendarEventModel? event}) async {
    NoteAndDoctorModel? noteOrDoctor;
    if (event != null) noteOrDoctor = NoteAndDoctorModel.fromJSON(json.decode(event.jsonEvent));
    final result = isDoctor
        ? await Get.toNamed(UtilRoutes.addDoctor, arguments: {'date': selectedDate.value, 'event': noteOrDoctor})
        : await Get.toNamed(UtilRoutes.addNote, arguments: {'date': selectedDate.value, 'event': noteOrDoctor});
    if (result != null) {
      NoteAndDoctorModel noteAndDoctor = result;
      if (event != null) {
        await calendarRepository.editEvent(
          date: selectedDate.value,
          newDate: noteAndDoctor.date,
          event: event,
          newEvent: CalendarEventModel(
            title: isDoctor ? 'Запись к врачу:' : null,
            eventType: isDoctor ? CalendarEventTypeModel.doctor : CalendarEventTypeModel.note,
            jsonEvent: json.encode(noteAndDoctor.toJSON()),
            timeInt: noteAndDoctor.date.hour * 60 + noteAndDoctor.date.minute,
          ),
        );
      } else {
        await calendarRepository.addEvent(
          date: noteAndDoctor.date,
          event: CalendarEventModel(
            title: isDoctor ? 'Запись к врачу:' : null,
            eventType: isDoctor ? CalendarEventTypeModel.doctor : CalendarEventTypeModel.note,
            jsonEvent: json.encode(noteAndDoctor.toJSON()),
            timeInt: noteAndDoctor.date.hour * 60 + noteAndDoctor.date.minute,
          ),
        );
      }
      updateList();
    }
  }

  Future<void> addMedicament({CalendarEventModel? event}) async {
    MedicamentModel? editMedicament;
    if (event != null) editMedicament = MedicamentModel.fromJSON(json.decode(event.jsonEvent));
    final result = await Get.toNamed(
      UtilRoutes.addMedicament,
      arguments: {'date': selectedDate.value, 'event': editMedicament},
    );
    if (result != null) {
      MedicamentModel medicament = result;
      if (event != null) {
        for (var _date in editMedicament!.dates) {
          await calendarRepository.removeEvent(date: _date, event: event);
        }
      }
      for (int i = 0; i < medicament.duration; i++) {
        if (medicament.period != 'Каждый день') i++;
        await calendarRepository.addEvent(
          date: medicament.dateStart.add(Duration(days: i)),
          event: CalendarEventModel(
            title: 'Приём медикаментов:',
            eventType: CalendarEventTypeModel.medicament,
            jsonEvent: json.encode(medicament.toJSON()),
            timeInt: medicament.times.first.hour * 60 + medicament.times.first.minute,
          ),
        );
      }
      updateList();
    }
  }

  Future<void> editEvent(CalendarEventModel event) async {
    switch (event.eventType.stringCode) {
      case 'NOTE':
        addNoteAndDoctor(false, event: event);
        break;
      case 'DOCTOR':
        addNoteAndDoctor(true, event: event);
        break;
      case 'MEDICAMENT':
        addMedicament(event: event);
        break;
      default:
        break;
    }

    updateList();
  }

  void updateList() {
    dayItems.value = calendarRepository.days;
    onDaySelected(selectedDate.value, selectedDate.value);
    dayItems.refresh();
    update(['calendar']);
  }
}
