import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/daily_advice_view/daily_advice_view_controller.dart';

class DailyAdviceViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DailyAdviceViewController>(DailyAdviceViewController());
  }
}
