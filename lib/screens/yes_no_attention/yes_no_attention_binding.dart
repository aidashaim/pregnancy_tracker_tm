import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/yes_no_attention/yes_no_attention_controller.dart';

class YesNoAttentionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<YesNoAttentionController>(YesNoAttentionController());
  }
}
