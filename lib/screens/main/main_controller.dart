import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_screen.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_screen.dart';
import 'package:pregnancy_tracker_tm/screens/masters/masters_screen.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_screen.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<String> items = [UtilIcons.home, UtilIcons.calendarMenu, UtilIcons.masters, UtilIcons.settings];

  final List<Widget Function()> screenBuilders = [
    () => const HomeScreen(),
    () => const CalendarScreen(),
    () => const MastersScreen(),
    () => const SettingsScreen(),
  ];

  int selectIndex(int index) => selectedIndex.value = index;
}
