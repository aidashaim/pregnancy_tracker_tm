import 'dart:io';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:share/share.dart';

class DailyAdviceViewController extends GetxController {
  late Rx<DailyAdviceModel> article;

  @override
  void onInit() {
    super.onInit();
    article = (Get.arguments['article'] as DailyAdviceModel).obs;
  }

  Future<void> saveArticle() async {
    await dailyAdviceRepository.addDailyAdvice(dailyAdvice: article.value);
    article.value.isSaved = !article.value.isSaved;
    article.refresh();
  }

  Future<void> share() async {
    String appUrl = Platform.isAndroid ? UtilRepo.shareUrlAndroid : UtilRepo.shareUrlIOS;
    await Share.share('${UtilFormatters.deleteHtmlTags(article.value.text)} \n$appUrl');
  }
}
