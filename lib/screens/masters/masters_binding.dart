import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/masters/masters_controller.dart';

class MastersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MastersController>(MastersController());
  }
}
