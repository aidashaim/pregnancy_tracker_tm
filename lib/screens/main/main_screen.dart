import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/main/main_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => buildBody(controller.selectedIndex.value)),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: Obx(
          () => SizedBox(
            child: BottomNavigationBar(
              unselectedItemColor: UtilColors.navigationGrey,
              selectedItemColor: UtilColors.mainRed,
              currentIndex: controller.selectedIndex.value,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              onTap: controller.selectIndex,
              items: _buildBottomNavigationBar(),
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBar() {
    return controller.items
        .map(
          (icon) => _buildBottomNavigationBarItem(
            icon: icon,
            active: controller.selectedIndex.value == controller.items.indexOf(icon),
          ),
        )
        .toList();
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    bool active = false,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        padding: EdgeInsets.only(top: 10.w),
        child: UtilIcons(icon, color: active ? UtilColors.redBg : UtilColors.navigationGrey),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildBody(int index) {
    return controller.screenBuilders[index]();
  }
}
