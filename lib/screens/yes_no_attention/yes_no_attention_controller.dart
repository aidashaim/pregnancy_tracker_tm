import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class YesNoAttentionController extends GetxController {
  late List<CanOrCantModel> yesNoItems;
  late String title;

  @override
  void onInit() {
    super.onInit();
    yesNoItems = Get.arguments['canOrCants'];
    title = Get.arguments['title'];
  }

  void tapOnArticle(CanOrCantModel canOrCant) {
    Get.toNamed(UtilRoutes.articleView, arguments: {'canOrCant': canOrCant});
  }
}
