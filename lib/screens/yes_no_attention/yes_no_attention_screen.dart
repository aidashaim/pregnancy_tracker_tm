import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/yes_no_attention/widgets/yes_no_item.dart';
import 'package:pregnancy_tracker_tm/screens/yes_no_attention/yes_no_attention_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class YesNoAttentionScreen extends GetView<YesNoAttentionController> {
  const YesNoAttentionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Column(
          children: [
            BackButtonWithTitle(title: controller.title, needInfo: true),
            SizedBox(height: 5.w),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return false;
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    itemBuilder: (context, index) =>
                        YesNoItem(canOrCant: controller.yesNoItems[index], onTap: controller.tapOnArticle),
                    separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
                    itemCount: controller.yesNoItems.length,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.w),
          ],
        ),
      ),
    );
  }
}
