import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/can_or_cant/can_or_cant_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class CanOrCantScreen extends GetView<CanOrCantController> {
  const CanOrCantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.mastersBg,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const BackButtonWithTitle(title: 'Что можно и нельзя', isWhite: true),
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(15.w),
              itemCount: controller.gridItems.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.w,
                childAspectRatio: 1.33,
              ),
              itemBuilder: (BuildContext context, int index) => controller.gridItems[index],
            ),
          ],
        ),
      ),
    );
  }
}
