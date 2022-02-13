import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/saved_articles/saved_articles_controller.dart';

class SavedArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SavedArticlesController>(SavedArticlesController());
  }
}
