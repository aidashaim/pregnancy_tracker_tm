import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/choose_name/choose_name_controller.dart';
import 'package:pregnancy_tracker_tm/screens/choose_name/widgets/name_list_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_images.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class ChooseNameScreen extends GetView<ChooseNameController> {
  const ChooseNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: UtilColors.mastersBg,
        floatingActionButton: controller.selectedTab.value != 2 ? addFloatingButton() : const SizedBox(),
        body: SafeArea(
          child: Column(
            children: [
              const BackButtonWithTitle(title: 'Выбрать имя', isWhite: true),
              Container(
                padding: EdgeInsets.only(top: 10.w),
                decoration: BoxDecoration(
                  color: UtilColors.tabBarBg,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                ),
                child: TabBar(
                  labelColor: UtilColors.darkGrey,
                  unselectedLabelColor: UtilColors.darkGrey,
                  labelStyle: UtilTextStyles.mastersTitle,
                  indicatorColor: UtilColors.mainRed,
                  indicatorWeight: 3.w,
                  controller: controller.tabController,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    SizedBox(
                      width: Get.size.width / 3,
                      child: Tab(text: 'Для девочки', icon: UtilIcons(UtilIcons.girl, width: 36.w)),
                    ),
                    SizedBox(
                      width: Get.size.width / 3,
                      child: Tab(text: 'Для мальчика', icon: UtilIcons(UtilIcons.boy, width: 36.w)),
                    ),
                    SizedBox(
                      width: Get.size.width / 3,
                      child: Tab(text: 'Избранное', icon: Image.asset(UtilImages.saved, width: 36.w)),
                    ),
                  ],
                ),
              ),
              Container(width: Get.size.width, height: 1.w, color: UtilColors.mainRed),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [nameList(0), nameList(1), nameList(2)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addFloatingButton() {
    return GestureDetector(
      onTap: controller.addName,
      child: Container(
          padding: EdgeInsets.all(12.w),
          margin: EdgeInsets.only(bottom: 20.w),
          decoration: BoxDecoration(color: UtilColors.mainRed, shape: BoxShape.circle),
          child: UtilIcons(UtilIcons.add, height: 31.w)),
    );
  }

  Widget nameList(int listIndex) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 20.w),
      itemBuilder: (context, index) => NameListItem(
        name: controller.nameLists[listIndex][index],
        saveNameTap: controller.saveNameTap,
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
      itemCount: controller.nameLists[listIndex].length,
    );
  }
}
