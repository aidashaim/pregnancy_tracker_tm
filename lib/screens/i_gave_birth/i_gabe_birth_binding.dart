import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/i_gave_birth/i_gabe_birth_controller.dart';

class IGabeBirthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IGabeBirthController>(IGabeBirthController());
  }
}
