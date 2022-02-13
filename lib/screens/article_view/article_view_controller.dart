import 'dart:io';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:share/share.dart';

class ArticleViewController extends GetxController {
  late CanOrCantModel canOrCant;

  @override
  void onInit() {
    super.onInit();
    canOrCant = Get.arguments['canOrCant'];
  }

  Future<void> share() async {
    String appUrl = Platform.isAndroid ? UtilRepo.shareUrlAndroid : UtilRepo.shareUrlIOS;
    await Share.share('${UtilFormatters.deleteHtmlTags(canOrCant.text)} \n$appUrl');
  }

  Future<void> saveArticle() async {
    await dailyAdviceRepository.addArticle(article: canOrCant);
    canOrCant.isSaved = !canOrCant.isSaved;
    update(['saved']);
  }
}
