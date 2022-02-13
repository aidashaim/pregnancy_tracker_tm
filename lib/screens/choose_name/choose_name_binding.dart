import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/choose_name/choose_name_controller.dart';

class ChooseNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChooseNameController>(ChooseNameController());
  }
}
