import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/add_note_and_doctor/add_note_and_doctor_controller.dart';

class AddNoteAndDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddNoteAndDoctorController>(AddNoteAndDoctorController());
  }
}
