import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
