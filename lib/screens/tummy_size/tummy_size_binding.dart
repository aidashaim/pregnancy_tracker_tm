import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/tummy_size/tummy_size_controller.dart';

class TummySizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TummySizeController>(TummySizeController());
  }
}
