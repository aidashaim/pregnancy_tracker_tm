import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/movement_counter/movement_counter_controller.dart';

class MovementCounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MovementCounterController>(MovementCounterController());
  }
}
