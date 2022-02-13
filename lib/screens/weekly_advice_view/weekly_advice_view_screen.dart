import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/weekly_advice_view/weekly_advice_view_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/ad_banner.dart';
import 'package:pregnancy_tracker_tm/widgets/blur_image.dart';
import 'package:pregnancy_tracker_tm/widgets/html_text.dart';

class WeeklyAdviceViewScreen extends GetView<WeeklyAdviceViewController> {
  const WeeklyAdviceViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: GestureDetector(
        onTapDown: (TapDownDetails details) => controller.tapToStory(details),
        child: story(),
      ),
    );
  }

  Widget storyIndicator(bool isShown) {
    return Container(
      width: (Get.size.width - controller.weeks * 6.w - 30.w) / controller.weeks,
      height: 6.w,
      margin: EdgeInsets.fromLTRB(3.w, 15.w, 3.w, 0),
      decoration: BoxDecoration(
        color: UtilColors.disabled.withOpacity(isShown ? 1 : .5),
        borderRadius: BorderRadius.all(Radius.circular(100.w)),
      ),
    );
  }

  Widget story() {
    List<int> list = List<int>.generate(controller.weeks, (i) => i++);
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.mediaQuery.padding.top - 15.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: list.map((e) => storyIndicator(e < controller.currentStoryIndex.value)).toList(),
                  ),
                  SizedBox(height: 15.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.title.value, style: UtilTextStyles.priceTitle, textAlign: TextAlign.start),
                      Row(
                        children: [
                          InkWell(
                            onTap: controller.share,
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: UtilIcons(UtilIcons.share, height: 20.w, color: UtilColors.iconGrey),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.back(),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: UtilIcons(UtilIcons.close, height: 20.w, color: UtilColors.iconGrey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.w),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                      child: Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              if (controller.advice.value.img.isNotEmpty) BlurImage(img: controller.advice.value.img),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 8.w),
                                    Text(controller.advice.value.title, style: UtilTextStyles.dialogTitle),
                                    SizedBox(height: 10.w),
                                    HtmlText(text: controller.advice.value.text),
                                    SizedBox(height: 10.w),
                                  ],
                                ),
                              ),
                              adBlock(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget adBlock() => AdBanner(padding: 30.w);
}
