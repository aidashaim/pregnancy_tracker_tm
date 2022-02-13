import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/masters/masters_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class MastersScreen extends GetView<MastersController> {
  const MastersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.mastersBg,
      body: SafeArea(
        child: //Obx(
            //() =>
            ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.w),
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Помощники', style: UtilTextStyles.whiteTitle),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 15.w, bottom: 20.w),
              itemCount: controller.mastersItems.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.w,
                childAspectRatio: 1.33,
              ),
              itemBuilder: (BuildContext context, int index) => controller.mastersItems[index],
            ),
          ],
          // ),
        ),
      ),
    );
  }
}
