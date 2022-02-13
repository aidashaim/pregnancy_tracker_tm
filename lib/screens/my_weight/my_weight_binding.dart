import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/my_weight/my_weight_controller.dart';

class MyWeightBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyWeightController>(MyWeightController());
  }
}
