import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/shopping_plan/shopping_plan_controller.dart';

class ShoppingPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShoppingPlanController>(ShoppingPlanController());
  }
}
