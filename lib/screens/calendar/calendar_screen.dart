import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_model.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_type_model.dart';
import 'package:pregnancy_tracker_tm/models/medicament_model.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/models/note_and_doctor_model.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends GetView<CalendarController> {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      floatingActionButton: addFloatingButton(),
      body: SafeArea(
        child: SizedBox(
          width: Get.size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Календарь', style: UtilTextStyles.priceTitle),
                    UtilIcons(UtilIcons.info, height: 30.w),
                  ],
                ),
              ),
              GetBuilder<CalendarController>(
                id: "calendar",
                builder: (controller) => Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10.w,
                              top: 100.w,
                              child: Column(
                                children: [
                                  ...List<int>.generate(
                                          controller.weekInMonthCount.value, (i) => controller.weeks.value + i - 1)
                                      .map(
                                        (week) => Padding(
                                          padding: EdgeInsets.only(bottom: 28.w),
                                          child: Text(week.toString(), style: UtilTextStyles.calendarWeek),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2.w),
                              child: TableCalendar<CalendarEventModel>(
                                firstDay: controller.firstDay,
                                lastDay: controller.lastDay,
                                focusedDay: controller.focusedDay.value,
                                daysOfWeekHeight: 40.w,
                                rowHeight: 43.w,
                                selectedDayPredicate: (day) => isSameDay(controller.selectedDate.value, day),
                                calendarFormat: CalendarFormat.month,
                                eventLoader: controller.getEventsForDay,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: UtilTextStyles.greyText,
                                  weekendStyle: UtilTextStyles.greyText,
                                ),
                                headerStyle: HeaderStyle(
                                  titleCentered: true,
                                  titleTextStyle: UtilTextStyles.dialogTitle,
                                  leftChevronIcon: UtilIcons(UtilIcons.arrowLeft),
                                  rightChevronIcon: UtilIcons(UtilIcons.arrowRight),
                                  headerPadding: EdgeInsets.symmetric(vertical: 10.w),
                                  decoration: BoxDecoration(color: UtilColors.greyBg),
                                  titleTextFormatter: (date, _) => DateFormat.MMMM().format(date).capitalizeFirst ?? '',
                                ),
                                calendarStyle: CalendarStyle(
                                  outsideDaysVisible: false,
                                  todayTextStyle: UtilTextStyles.calendarDay,
                                  defaultTextStyle: UtilTextStyles.calendarDay,
                                  disabledTextStyle: UtilTextStyles.calendarDay,
                                  holidayTextStyle: UtilTextStyles.calendarDay,
                                  selectedTextStyle: UtilTextStyles.calendarDay,
                                  weekendTextStyle: UtilTextStyles.calendarDay,
                                  outsideTextStyle: UtilTextStyles.calendarDay,
                                  todayDecoration: const BoxDecoration(color: Colors.transparent),
                                  selectedDecoration:
                                      BoxDecoration(shape: BoxShape.circle, color: UtilColors.selectedDay),
                                  markerMargin: EdgeInsets.all(5.w),
                                  markersAlignment: Alignment.topRight,
                                ),
                                calendarBuilders: CalendarBuilders(markerBuilder: eventMarker),
                                onDaySelected: controller.onDaySelected,
                                onPageChanged: controller.monthChanged,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          helpItem('Заметка', UtilIcons.notes),
                          helpItem('Настроение', UtilIcons.mood),
                          helpItem('Приём к врачу', UtilIcons.pharmacy),
                        ],
                      ),
                      SizedBox(height: 20.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.w)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${DateFormat.MMMMd().format(controller.selectedDate.value)}:',
                                    style: UtilTextStyles.dropDownTitle,
                                  ),
                                ),
                                controller.selectedDayMood.value != null
                                    ? UtilIcons(MoodModel.mapIcons[controller.selectedDayMood.value!.stringCode]!)
                                    : AppButton(
                                        title: 'Указать настроение',
                                        isRound: true,
                                        bgColor: UtilColors.yellow,
                                        titleColor: UtilColors.darkGrey,
                                        onTap: controller.chooseMood,
                                      ),
                              ],
                            ),
                            SizedBox(height: 15.w),
                            controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.selectedEvents.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: controller.selectedEvents.isNotEmpty ? 60.w : 0),
                                    itemBuilder: (context, index) => eventItems(controller.selectedEvents[index]),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventItems(CalendarEventModel event) {
    if (event.eventType == CalendarEventTypeModel.mood) return const SizedBox();
    late Color bgColor;
    late String text;
    late String date;
    late MedicamentModel medicament;
    switch (event.eventType.stringCode) {
      case 'NOTE':
        NoteAndDoctorModel note = NoteAndDoctorModel.fromJSON(json.decode(event.jsonEvent));
        date = 'весь день';
        text = note.text;
        bgColor = UtilColors.green.withOpacity(.22);
        break;
      case 'MEDICAMENT':
        date = '';
        medicament = MedicamentModel.fromJSON(json.decode(event.jsonEvent));
        for (var e in medicament.times) {
          date += UtilFormatters.time(e);
          if (e != medicament.times.last) date += ', ';
        }
        text = medicament.name + ' по ' + medicament.dosage + ' шт.';
        bgColor = UtilColors.yellow.withOpacity(.22);
        break;
      case 'DOCTOR':
        NoteAndDoctorModel doctor = NoteAndDoctorModel.fromJSON(json.decode(event.jsonEvent));
        date = UtilFormatters.time(TimeOfDay.fromDateTime(doctor.date));
        text = doctor.text;
        bgColor = UtilColors.markerRed.withOpacity(.18);
        break;
    }

    return InkWell(onTap: () => controller.editEvent(event), child: eventItem(bgColor, text, date, event.title));
  }

  Widget eventItem(Color bgColor, String text, String date, String? title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
      margin: EdgeInsets.symmetric(vertical: 4.w),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5.w)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: UtilTextStyles.greyText
                        .merge(TextStyle(fontWeight: FontWeight.w700, color: UtilColors.darkGrey)),
                  ),
                Text(text, style: UtilTextStyles.greyText),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(child: Text(date, style: UtilTextStyles.dropDownTitle, textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget eventMarker(BuildContext context, DateTime date, List<CalendarEventModel> events) {
    bool hasMood = false;
    bool hasNote = false;
    bool hasPharmacy = false;
    for (var event in events) {
      if (event.eventType == CalendarEventTypeModel.note) hasNote = true;
      if (event.eventType == CalendarEventTypeModel.mood) hasMood = true;
      if (event.eventType == CalendarEventTypeModel.medicament || event.eventType == CalendarEventTypeModel.doctor) {
        hasPharmacy = true;
      }
    }
    return events.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(right: 10.w, bottom: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (hasNote) ...[UtilIcons(UtilIcons.notes), SizedBox(height: 2.w)],
                if (hasMood) ...[UtilIcons(UtilIcons.mood), SizedBox(height: 2.w)],
                if (hasPharmacy) UtilIcons(UtilIcons.pharmacy),
              ],
            ))
        : const SizedBox();
  }

  Widget addFloatingButton() {
    return GestureDetector(
      onTap: controller.addAction,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 20.w),
        decoration: BoxDecoration(color: UtilColors.mainRed, shape: BoxShape.circle),
        child: UtilIcons(UtilIcons.add, height: 31.w),
      ),
    );
  }

  Widget helpItem(String title, String icon) {
    return Row(
      children: [UtilIcons(icon), SizedBox(width: 10.w), Text(title, style: UtilTextStyles.helpStyle)],
    );
  }
}
