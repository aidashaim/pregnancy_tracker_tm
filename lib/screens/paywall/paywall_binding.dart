import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_controller.dart';

class PaywallBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaywallController>(PaywallController());
  }
}
