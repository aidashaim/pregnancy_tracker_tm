import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/daily_advice_view/daily_advice_view_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/ad_banner.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/blur_image.dart';
import 'package:pregnancy_tracker_tm/widgets/html_text.dart';

class DailyAdviceViewScreen extends GetView<DailyAdviceViewController> {
  const DailyAdviceViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: Column(
        children: [
          SizedBox(height: Get.mediaQuery.padding.top),
          const BackButtonWithTitle(title: 'Статья', needInfo: true),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w)),
              child: Container(
                color: Colors.white,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return false;
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          controller.article.value.img.isNotEmpty
                              ? BlurImage(img: controller.article.value.img, height: 200.w)
                              : SizedBox(height: 200.w),
                          Positioned(
                            right: 15.w,
                            top: 15.w,
                            child: InkWell(
                              onTap: controller.share,
                              child: Container(
                                padding: EdgeInsets.all(7.w),
                                width: 36.w,
                                height: 36.w,
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: FittedBox(
                                  child: UtilIcons(UtilIcons.share),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Positioned(
                              right: 15.w,
                              top: 53.w,
                              child: InkWell(
                                onTap: controller.saveArticle,
                                child: Container(
                                  padding: EdgeInsets.all(7.w),
                                  width: 36.w,
                                  height: 36.w,
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: FittedBox(
                                    child: UtilIcons(
                                      UtilIcons.saved,
                                      color: controller.article.value.isSaved ? UtilColors.savedYellow : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.article.value.title, style: UtilTextStyles.dialogTitle),
                            SizedBox(height: 15.w),
                            HtmlText(text: controller.article.value.text),
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
    );
  }

  Widget adBlock() => const AdBanner();
}
