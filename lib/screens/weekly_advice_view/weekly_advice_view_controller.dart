import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/weekly_advice_model.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/weekly_advices_repository.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';
import 'package:pregnancy_tracker_tm/services/api_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:share/share.dart';

class WeeklyAdviceViewController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final RxBool isLoading = false.obs;
  Rx<WeeklyAdviceModel> advice = WeeklyAdviceModel(text: '', img: '', title: '').obs;
  RxString title = ''.obs;
  RxInt currentStoryIndex = 0.obs;
  late int weeks;
  late int _index;

  @override
  void onInit() {
    super.onInit();
    weeks = currentStoryIndex.value = userRepository.currentUser.currentWeek;
    _index = Get.arguments;
    getWeeklyAdvice();
  }

  Future<void> getWeeklyAdvice() async {
    isLoading.value = true;
    late final Response response;
    switch (_index) {
      case 0:
        response = await _apiService.getWeeklyAdviceBaby(week: currentStoryIndex.value);
        break;
      case 1:
        response = await _apiService.getWeeklyAdviceMom(week: currentStoryIndex.value);
        break;
      case 2:
        response = await _apiService.getWeeklyAdviceGeneral(week: currentStoryIndex.value);
        break;
    }
    if (response.isOk && response.body != null) {
      advice.value = response.body!;
      title.value = UtilFormatters.gestationalAge(term: currentStoryIndex.value * 7, withDays: false);
    }
    isLoading.value = false;
  }

  Future<void> tapToStory(TapDownDetails details) async {
    if (details.localPosition.dx < Get.size.width / 2) {
      if (currentStoryIndex.value - 1 > 0) {
        currentStoryIndex.value--;
        getWeeklyAdvice();
        return;
      } else {
        await weeklyAdvicesRepository.addShown(adviceIndex: _index);
        Get.find<HomeController>().updateWeeklyAdvices();
      }
    } else {
      if (currentStoryIndex.value + 1 <= weeks) {
        currentStoryIndex.value++;
        getWeeklyAdvice();
        return;
      }
    }
    Get.back();
  }

  Future<void> share() async {
    String appUrl = Platform.isAndroid ? UtilRepo.shareUrlAndroid : UtilRepo.shareUrlIOS;
    await Share.share('${UtilFormatters.deleteHtmlTags(advice.value.text)} \n$appUrl');
  }
}
