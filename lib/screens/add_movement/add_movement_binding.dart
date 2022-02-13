import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/add_movement/add_movement_controller.dart';

class AddMovementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddMovementController>(AddMovementController());
  }
}
