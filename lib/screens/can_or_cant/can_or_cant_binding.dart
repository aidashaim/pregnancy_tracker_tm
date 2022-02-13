import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/can_or_cant/can_or_cant_controller.dart';

class CanOrCantBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CanOrCantController>(CanOrCantController());
  }
}
