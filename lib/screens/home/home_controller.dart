import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_model.dart';
import 'package:pregnancy_tracker_tm/models/calendar_event_type_model.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/repositories/calendar_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/my_weight_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/tummy_size_repository.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/weekly_advice_group_model.dart';
import 'package:pregnancy_tracker_tm/repositories/weekly_advices_repository.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_controller.dart';
import 'package:pregnancy_tracker_tm/services/api_service.dart';
import 'package:pregnancy_tracker_tm/services/interstitial_ad_service.dart';
import 'package:pregnancy_tracker_tm/services/purchase_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_images.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class HomeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final RxBool isLoading = false.obs;
  final RxBool isAdvicesLoading = false.obs;
  final RxBool hasWeightToday = false.obs;
  final RxBool hasSizeToday = false.obs;
  final RxBool isUserPro = false.obs;
  final RxList<WeeklyAdviceGroupModel> weeklyAdvices = <WeeklyAdviceGroupModel>[].obs;
  final RxList<DailyAdviceModel> dailyAdvices = <DailyAdviceModel>[].obs;
  final Rx<MoodModel?> selectedDayMood = Rx<MoodModel?>(null);
  List<String> savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
  final ScrollController listController = ScrollController();
  final int pageSize = 6;
  late DateTime dateOfBirth;
  late String gestationalAge;
  late String beforeBirth;
  late int days;

  @override
  void onInit() {
    dateOfBirth = userRepository.currentUser.dateOfBirth;
    final int afterNow = dateOfBirth.difference(DateTime.now()).inDays;
    final int beforeNow = UtilRepo.pregnancyDuration - afterNow;
    beforeBirth = UtilFormatters.gestationalAge(term: afterNow, twoLines: true);
    gestationalAge = UtilFormatters.gestationalAge(term: beforeNow, twoLines: true);
    days = beforeNow;
    if (days > UtilRepo.pregnancyDuration) days = UtilRepo.pregnancyDuration;
    selectedDayMood.value = calendarRepository.days
        .firstWhereOrNull((day) => UtilFormatters.date(day.date) == UtilFormatters.date(DateTime.now()))
        ?.getMood;
    hasWeightToday.value = myWeightRepository.hasWeightToday;
    hasSizeToday.value = tummySizeRepository.hasSizeToday;
    updateWeeklyAdvices();
    listController.addListener(() {
      getDailyAdvices();
    });
    isUserPro.value = PurchaseService.instance.isProUser;
    fetchDailyAdvices(days - dailyAdvices.length);
    super.onInit();
  }

  void updateWeeklyAdvices() {
    List<bool> shown = weeklyAdvicesRepository.advicesShown;
    weeklyAdvices
      ..clear()
      ..addAll([
        WeeklyAdviceGroupModel(img: UtilImages.adviceBaby, title: 'Малыш', isShown: shown[0]),
        WeeklyAdviceGroupModel(img: UtilImages.adviceMom, title: 'Мама', isShown: shown[1]),
        WeeklyAdviceGroupModel(img: UtilImages.adviceGeneral, title: 'Совет', isShown: shown[2]),
      ]);
    update(['weeklyAdvices']);
  }

  void goToWeeklyAdvice(int index) {
    Get.toNamed(UtilRoutes.weeklyAdviceView, arguments: index);
  }

  Future<void> getDailyAdvices() async {
    if (isAdvicesLoading.value) {
      return;
    }
    isAdvicesLoading.value = true;
    if (listController.offset == listController.position.maxScrollExtent) {
      await fetchDailyAdvices(days - dailyAdvices.length);
    }
    isAdvicesLoading.value = false;
  }

  Future<void> fetchDailyAdvices(int pageKey) async {
    if (pageKey > days || pageKey < 0) {
      return;
    }
    final int lastIndex = pageKey - pageSize < 1 ? 0 : pageKey - pageSize;
    for (var i = pageKey; i > lastIndex; i--) {
      final Response response = await _apiService.getDailyAdvices(day: i);
      if (response.isOk && response.body != null) {
        DailyAdviceModel advice = response.body;
        advice.day = i;
        advice.isSaved = savedDailyAdvices.firstWhereOrNull((e) => e == '${i.toString()}/ru') != null;
        dailyAdvices.add(advice);
      }
    }
  }

  Future<void> onArticleTap(DailyAdviceModel article) async {
    if (!isUserPro.value) InterstitialAdService.showInterstitialAd(1);
    await Get.toNamed(UtilRoutes.dailyAdviceView, arguments: {'article': article});
    savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
    dailyAdvices.firstWhere((e) => e == article).isSaved =
        savedDailyAdvices.firstWhereOrNull((e) => e == '${article.day!.toString()}/ru') != null;
    dailyAdvices.refresh();
  }

  Future<void> saveArticle(DailyAdviceModel article) async {
    await dailyAdviceRepository.addDailyAdvice(dailyAdvice: article);
    savedDailyAdvices = dailyAdviceRepository.dailyAdvices;
    dailyAdvices.firstWhere((e) => e == article).isSaved = !article.isSaved;
    dailyAdvices.refresh();
  }

  void buyPro() {
    Get.toNamed(UtilRoutes.paywall);
  }

  Future<void> selectMood(MoodModel mood) async {
    DateTime now = DateTime.now();
    selectedDayMood.value = mood;
    await calendarRepository.addEvent(
      date: now,
      event: CalendarEventModel(eventType: CalendarEventTypeModel.mood, jsonEvent: mood.stringCode, timeInt: 0),
    );
    Get.find<CalendarController>().updateList();
  }

  Future<void> addWeightAndSize(String route) async {
    await Get.toNamed(route);
    hasWeightToday.value = myWeightRepository.hasWeightToday;
    hasSizeToday.value = tummySizeRepository.hasSizeToday;
  }

  double getTextHeight(String text) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: text, style: UtilTextStyles.moodTitle), textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: ((Get.size.width - 30.w) * .7) - 60.w - ((Get.size.width - 30.w) * .3));
    return textPainter.size.height + 74.w;
  }
}
