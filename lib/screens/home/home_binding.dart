import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
