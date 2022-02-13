import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/select_time/select_time_controller.dart';

class SelectTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SelectTimeController>(SelectTimeController());
  }
}
