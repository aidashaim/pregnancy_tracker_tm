import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';
import 'package:pregnancy_tracker_tm/screens/home/widgets/baby_fruit.dart';
import 'package:pregnancy_tracker_tm/screens/home/widgets/weekly_advices.dart';
import 'package:pregnancy_tracker_tm/widgets/ad_banner.dart';
import 'package:pregnancy_tracker_tm/widgets/article_preview.dart';
import 'package:pregnancy_tracker_tm/screens/home/widgets/main_header.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_images.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/mood_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.mainScaffoldGrey,
      body: Obx(
        () => NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            controller: controller.listController,
            children: [
              MainHeader(
                dateOfBirth: UtilFormatters.date(controller.dateOfBirth),
                gestationalAge: controller.gestationalAge,
                beforeBirth: controller.beforeBirth,
                days: controller.days,
              ),
              SizedBox(height: 20.w),
              GetBuilder<HomeController>(
                id: "weeklyAdvices",
                builder: (controller) =>
                    WeeklyAdvices(advices: controller.weeklyAdvices, onTap: controller.goToWeeklyAdvice),
              ),
              SizedBox(height: 20.w),
              if (controller.days ~/ 7 > 35) iBornWidget(),
              SizedBox(height: 20.w),
              BabyFruit(),
              SizedBox(height: 20.w),
              if (!controller.hasWeightToday.value || !controller.hasSizeToday.value) ...[
                SizedBox(
                  height: controller.getTextHeight('Самое время взвеситься'),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (!controller.hasWeightToday.value)
                        weightAndHeight('Самое время взвеситься', UtilImages.weight, UtilRoutes.myWeight),
                      if (!controller.hasSizeToday.value)
                        weightAndHeight('Пора измерить животик', UtilImages.height, UtilRoutes.tummySize),
                    ],
                  ),
                ),
                SizedBox(height: 20.w),
              ],
              controller.selectedDayMood.value == null ? moodWidget() : const SizedBox(),
              if (controller.isUserPro.value) ...[
                SizedBox(height: 20.w),
                buyProWidget(),
              ],
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.dailyAdvices.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15.w),
                    child: ArticlePreview(
                      article: controller.dailyAdvices[index],
                      onTap: controller.onArticleTap,
                      onSavedTap: controller.saveArticle,
                      dateOffset: index,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => index % 3 == 2 ? adBlock() : const SizedBox(),
              ),
              controller.isAdvicesLoading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: Center(
                          child:
                              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg))),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget weightAndHeight(String text, String image, String route) {
    return Container(
      width: (Get.size.width - 30.w) * .7,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Text(text, style: UtilTextStyles.moodTitle)),
                SizedBox(width: (Get.size.width - 30.w) * .3)
              ],
            ),
          ),
          SizedBox(height: 12.w),
          Row(
            children: [
              AppButton(
                title: 'Добавить',
                isRound: true,
                buttonAlign: MainAxisAlignment.start,
                onTap: () => controller.addWeightAndSize(route),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget moodWidget() {
    return Container(
      width: double.maxFinite,
      height: 120.w,
      padding: EdgeInsets.all(18.w),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        children: [
          Text('Как настроение сегодня?', style: UtilTextStyles.moodTitle),
          SizedBox(height: 10.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...MoodModel.allMoods
                    .map((mood) => MoodItem(mood: mood, onTap: () => controller.selectMood(mood)))
                    .toList()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buyProWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.w)),
      child: Container(
        width: Get.size.width,
        height: Get.size.width / 2.2,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.fromLTRB(25.w, 30.w, (Get.size.width - 30.w) / 2, 30.w),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(UtilImages.pregnantWomen), fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Обновитесь до PRO', style: UtilTextStyles.dropDownTitle),
                  SizedBox(height: 5.w),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Text('Получите доступ ко всем статьям и функциям приложения',
                              style: UtilTextStyles.greyText)),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AppButton(
                      title: 'Получить Pro',
                      isRound: true,
                      buttonAlign: MainAxisAlignment.start,
                      onTap: controller.buyPro,
                    ),
                  ),
                ],
              ),
            ),

            //const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget iBornWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(UtilImages.born, width: Get.size.width),
          AppButton(
            title: 'Я родила!',
            bgColor: UtilColors.orange,
            isRound: true,
            onTap: () => Get.toNamed(UtilRoutes.iGaveBirth),
          ),
        ],
      ),
    );
  }

  Widget adBlock() {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20.w)), child: const AdBanner(isHome: true)),
    );
  }
}
