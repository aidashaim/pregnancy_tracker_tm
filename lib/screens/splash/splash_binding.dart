import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
