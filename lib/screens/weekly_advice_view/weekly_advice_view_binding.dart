import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/weekly_advice_view/weekly_advice_view_controller.dart';

class WeeklyAdviceViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WeeklyAdviceViewController>(WeeklyAdviceViewController());
  }
}
