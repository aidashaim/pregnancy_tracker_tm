import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/contraction_counter/contraction_counter_controller.dart';

class ContractionCounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ContractionCounterController>(ContractionCounterController());
  }
}
