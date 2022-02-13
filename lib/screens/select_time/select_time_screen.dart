import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/select_time/select_time_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/main_list_item.dart';

class SelectTimeScreen extends GetView<SelectTimeController> {
  const SelectTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Column(
          children: [
            BackButtonWithTitle(title: 'Напомнить', onTap: ()=>controller.goBack()),
            SizedBox(height: 5.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => timeItem(index),
                  separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
                  itemCount: controller.titles.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeItem(int index) {
    return Obx(
      () {
        bool _value = controller.selectValues[index];
        return InkWell(
          onTap: () => controller.selectTime(index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.w),
            child: IgnorePointer(
              child: MainListItem(
                title: controller.titles[index],
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: _value ? Colors.transparent : UtilColors.textFieldGrey,
                    borderRadius: BorderRadius.all(Radius.circular(3.w)),
                    border: Border.all(color: _value ? UtilColors.mainRed : UtilColors.navigationGrey),
                  ),
                  child: SizedBox(
                    height: 18.w,
                    width: 18.w,
                    child: Theme(
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: UtilColors.mainRed,
                        value: _value,
                        onChanged: (value) {},
                      ),
                      data: ThemeData(unselectedWidgetColor: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
