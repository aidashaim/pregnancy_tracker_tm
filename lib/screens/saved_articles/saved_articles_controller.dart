import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/services/api_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';

class SavedArticlesController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final RxList<dynamic> dailyAdvices = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  late List<String> savedDailyAdvices;
  late List<String> savedArticles;
  final ScrollController listController = ScrollController();
  final int pageSize = 5;

  @override
  void onInit() {
    savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
    savedArticles = dailyAdviceRepository.articles;
    listController.addListener(() {
      getDailyAdvices();
    });
    if (savedDailyAdvices.isNotEmpty || savedArticles.isNotEmpty) {
      fetchDailyAdvices(1);
    }
    super.onInit();
  }

  Future<void> onArticleTap(dynamic article) async {
    if (article is DailyAdviceModel) {
      await Get.toNamed(UtilRoutes.dailyAdviceView, arguments: {'article': article});
      savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
      if (savedDailyAdvices.firstWhereOrNull((e) => e == '${article.day!.toString()}/ru') == null) {
        dailyAdvices.remove(article);
        dailyAdvices.refresh();
      }
    } else {
      await Get.toNamed(UtilRoutes.articleView, arguments: {'canOrCant': article});
      savedArticles = dailyAdviceRepository.articles;
      if (savedArticles.firstWhereOrNull((e) => e == '${article.type}/${article.title}/ru') == null) {
        dailyAdvices.remove(article);
        dailyAdvices.refresh();
      }
    }
  }

  Future<void> deleteArticle(dynamic article) async {
    if (article is DailyAdviceModel) {
      await dailyAdviceRepository.addDailyAdvice(dailyAdvice: article);
      savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
    } else {
      await dailyAdviceRepository.addArticle(article: article);
      savedDailyAdvices = dailyAdviceRepository.articles;
    }
    dailyAdvices.remove(article);
    dailyAdvices.refresh();
  }

  Future<void> onSavedTap(dynamic article) async {
    bool isDelete = await Get.dialog<bool>(
          const AppDialog(
            title: 'Удалить материал из избранного? ',
            confirmButtonTitle: 'Ок',
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isDelete) {
      deleteArticle(article);
    }
  }

  Future<void> getDailyAdvices() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    if (listController.offset == listController.position.maxScrollExtent) {
      await fetchDailyAdvices(dailyAdvices.length + 1);
    }
    isLoading.value = false;
  }

  Future<void> fetchDailyAdvices(int pageKey) async {
    if (pageKey > savedDailyAdvices.length + savedArticles.length) {
      return;
    }
    if (pageKey <= savedDailyAdvices.length) {
      final int lastIndex =
          pageKey + pageSize > savedDailyAdvices.length ? savedDailyAdvices.length + 1 : pageKey + pageSize;
      for (var i = pageKey; i < lastIndex; i++) {
        int index = int.parse(savedDailyAdvices[i - 1].replaceFirst('/ru', ''));
        final Response response = await _apiService.getDailyAdvices(day: index);
        if (response.isOk && response.body != null) {
          DailyAdviceModel advice = response.body;
          advice.day = index;
          advice.isSaved = true;
          dailyAdvices.add(advice);
        }
      }
    }

    final int lastIndex = pageKey + pageSize > savedArticles.length ? savedArticles.length + 1 : pageKey + pageSize;
    for (var i = pageKey; i < lastIndex; i++) {
      var parts = savedArticles[i - 1].replaceFirst('/ru', '').split('/');
      String type = parts[0];
      String title = parts[1];
      final Response response = await _apiService.getCanOrCant(type: type);
      if (response.isOk && response.body != null) {
        List<CanOrCantModel> _list = [...response.body];
        CanOrCantModel? canOrCant = _list.firstWhereOrNull((e) => e.title == title);
        if (canOrCant != null) {
          canOrCant.type = type;
          canOrCant.isSaved = true;
          dailyAdvices.add(canOrCant);
        }
      }
    }
  }
}
