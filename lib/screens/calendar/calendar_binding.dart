import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CalendarController>(CalendarController());
  }
}
