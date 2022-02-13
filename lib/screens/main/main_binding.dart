import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
