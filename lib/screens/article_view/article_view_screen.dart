import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/article_view/article_view_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/ad_banner.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/blur_image.dart';
import 'package:pregnancy_tracker_tm/widgets/html_text.dart';

class ArticleViewScreen extends GetView<ArticleViewController> {
  const ArticleViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _status = controller.canOrCant.status;
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            BackButtonWithTitle(title: controller.canOrCant.title, needInfo: true),
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
                        if (controller.canOrCant.img.isNotEmpty)
                          Stack(
                            children: [
                              BlurImage(img: controller.canOrCant.img, height: 200.w),
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
                              Positioned(
                                right: 15.w,
                                top: 68.w,
                                child: GetBuilder<ArticleViewController>(
                                  id: 'saved',
                                  builder: (controller) => InkWell(
                                    onTap: () => controller.saveArticle(),
                                    child: Container(
                                      padding: EdgeInsets.all(7.w),
                                      width: 36.w,
                                      height: 36.w,
                                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                      child: FittedBox(
                                        child: UtilIcons(
                                          UtilIcons.saved,
                                          color: controller.canOrCant.isSaved ? UtilColors.savedYellow : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  UtilIcons(
                                    _status == '1'
                                        ? UtilIcons.yes
                                        : _status == '2'
                                            ? UtilIcons.attention
                                            : UtilIcons.no,
                                    width: 24.w,
                                  ),
                                  SizedBox(width: 15.w),
                                  Expanded(
                                      child: Text(
                                          _status == '1'
                                              ? 'Безопасно'
                                              : _status == '2'
                                                  ? 'Внимание'
                                                  : 'Опасно',
                                          style: UtilTextStyles.dropDownTitle)),
                                ],
                              ),
                              SizedBox(height: 15.w),
                              Text(controller.canOrCant.title, style: UtilTextStyles.dialogTitle),
                              SizedBox(height: 15.w),
                              HtmlText(text: controller.canOrCant.text),
                              SizedBox(height: 20.w),
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

  Widget adBlock() => const AdBanner();
}
