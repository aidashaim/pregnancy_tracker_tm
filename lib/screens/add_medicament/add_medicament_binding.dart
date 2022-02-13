import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/add_medicament/add_medicament_controller.dart';

class AddMedicamentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddMedicamentController>(AddMedicamentController());
  }
}
