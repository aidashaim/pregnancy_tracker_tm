import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/saved_articles/saved_articles_controller.dart';
import 'package:pregnancy_tracker_tm/widgets/article_preview.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class SavedArticlesScreen extends GetView<SavedArticlesController> {
  const SavedArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Column(
          children: [
            const BackButtonWithTitle(title: 'Избранное'),
            Expanded(
              child: Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.dailyAdvices.length,
                        physics: const BouncingScrollPhysics(),
                        controller: controller.listController,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(15.w),
                            child: ArticlePreview(
                              article: controller.dailyAdvices[index],
                              onTap: controller.onArticleTap,
                              onSavedTap: controller.onSavedTap,
                            ),
                          );
                        },
                      ),
                    ),
                    controller.isLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.w),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
