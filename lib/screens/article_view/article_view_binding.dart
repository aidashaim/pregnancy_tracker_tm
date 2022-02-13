import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/article_view/article_view_controller.dart';

class ArticleViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ArticleViewController>(ArticleViewController());
  }
}
