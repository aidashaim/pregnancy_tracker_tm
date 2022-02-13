import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/selectable_list_item.dart';
import 'package:pregnancy_tracker_tm/screens/hospital_bag/hospital_bag_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class HospitalBagScreen extends GetView<HospitalBagController> {
  const HospitalBagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.mastersBg,
      floatingActionButton: addFloatingButton(),
      body: SafeArea(
        child: Column(
          children: [
            const BackButtonWithTitle(title: 'Сумка в роддом', isWhite: true),
            Obx(
              () => Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                  ),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      itemBuilder: (context, index) => SelectableListItem(
                        bagItem: controller.hospitalBagItems[index],
                        onCheckTap: controller.selectItem,
                        onMenuTap: controller.selectAction,
                      ),
                      separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
                      itemCount: controller.hospitalBagItems.length,
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

  Widget addFloatingButton() {
    return GestureDetector(
      onTap: controller.addBagItem,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 20.w),
        decoration: BoxDecoration(color: UtilColors.mainRed, shape: BoxShape.circle),
        child: UtilIcons(UtilIcons.add, height: 31.w),
      ),
    );
  }
}
