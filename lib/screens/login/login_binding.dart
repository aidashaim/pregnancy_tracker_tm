import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
