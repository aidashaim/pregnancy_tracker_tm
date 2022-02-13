import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/shopping_plan/shopping_plan_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/selectable_list_item.dart';

class ShoppingPlanScreen extends GetView<ShoppingPlanController> {
  const ShoppingPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.mastersBg,
      floatingActionButton: addFloatingButton(),
      body: SafeArea(
        child: Column(
          children: [
            const BackButtonWithTitle(title: 'Список покупок', isWhite: true),
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
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Кроватка'),
                  Tab(text: 'Коляска'),
                  Tab(text: 'Купание'),
                  Tab(text: 'Кормление'),
                  Tab(text: 'Одежда'),
                  Tab(text: 'Подгузники'),
                  Tab(text: 'Аптечка'),
                ],
              ),
            ),
            Container(width: Get.size.width, height: 1.w, color: UtilColors.mainRed),
            Obx(
              () => Expanded(
                child: Container(
                  color: Colors.white,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      itemList(0),
                      itemList(1),
                      itemList(2),
                      itemList(3),
                      itemList(4),
                      itemList(5),
                      itemList(6),
                    ],
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
      onTap: controller.addListItem,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 20.w),
        decoration: BoxDecoration(color: UtilColors.mainRed, shape: BoxShape.circle),
        child: UtilIcons(UtilIcons.add, height: 31.w),
      ),
    );
  }

  Widget itemList(int listIndex) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 15.w),
      itemBuilder: (context, index) => SelectableListItem(
        bagItem: controller.itemLists[listIndex][index],
        onCheckTap: controller.selectItem,
        onMenuTap: controller.selectAction,
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
      itemCount: controller.itemLists[listIndex].length,
    );
  }
}
