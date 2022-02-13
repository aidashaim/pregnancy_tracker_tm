import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';

Future<TimeOfDay?> showCustomTimePicker() {
  return showTimePicker(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: UtilColors.mainRed,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              secondary: UtilColors.mainRed,
            ),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: UtilColors.mainRed)),
            timePickerTheme: TimePickerThemeData(
              entryModeIconColor: Colors.transparent,
              hourMinuteColor: Colors.transparent,
              dialBackgroundColor: UtilColors.greyBg,
              inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(fontSize: 40.sp)),
              hourMinuteTextColor: UtilColors.mainRed,
            ),
          ),
          child: child!,
        ),
      );
    },
    context: Get.context!,
    helpText: '',
    initialEntryMode: TimePickerEntryMode.dial,
    initialTime: const TimeOfDay(hour: 0, minute: 0),
  );
}

Future<DateTime?> showCustomDatePicker({DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) {
  return showDatePicker(
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: UtilColors.mainRed,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: UtilColors.mainRed)),
        ),
        child: child!,
      );
    },
    context: Get.context!,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 293)),
    lastDate: lastDate ?? DateTime.now().add(const Duration(days: 293)),
  );
}
