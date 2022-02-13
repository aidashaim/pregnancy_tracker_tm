import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/hospital_bag/hospital_bag_controller.dart';

class HospitalBagBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HospitalBagController>(HospitalBagController());
  }
}
