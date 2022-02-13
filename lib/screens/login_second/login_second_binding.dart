import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/login_second/login_second_controller.dart';

class LoginSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginSecondController>(LoginSecondController());
  }
}
