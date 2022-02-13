import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/add_movement/add_movement_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/main_list_item.dart';

class AddMovementScreen extends GetView<AddMovementController> {
  const AddMovementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              BackButtonWithTitle(title: 'Добавить шевеления', onTap: () => Get.back(result: null)),
              SizedBox(height: 5.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          UtilIcons(UtilIcons.calendar, height: 30.w),
                          SizedBox(width: 15.w),
                          Text(
                            UtilFormatters.dateWithMonth(controller.selectedDay.value),
                            style: UtilTextStyles.priceTitle,
                          ),
                          InkWell(
                            onTap: controller.selectDate,
                            child: Padding(
                              padding: EdgeInsets.all(15.w),
                              child: UtilIcons(UtilIcons.edit, height: 30.w),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.w),
                      MainListItem(
                        title: 'Время начала',
                        onTap: () => controller.selectTime(true),
                        child: Text(
                          controller.selectedTimeStart.value == null
                              ? 'Указать'
                              : UtilFormatters.time(controller.selectedTimeStart.value),
                          style: UtilTextStyles.dropDownTitle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.w),
                        child: Divider(color: UtilColors.lightGrey),
                      ),
                      MainListItem(
                        title: 'Время окончания',
                        onTap: () => controller.selectTime(false),
                        child: Text(
                          controller.selectedTimeEnd.value == null
                              ? 'Указать'
                              : UtilFormatters.time(controller.selectedTimeEnd.value),
                          style: UtilTextStyles.dropDownTitle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.w),
                        child: Divider(color: UtilColors.lightGrey),
                      ),
                      MainListItem(
                        title: 'Количество раз',
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            button('-', controller.decreaseCount),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 10.w,
                              child:
                                  Text(controller.selectedCount.value.toString(), style: UtilTextStyles.dropDownTitle),
                            ),
                            SizedBox(width: 10.w),
                            button('+', controller.increaseCount),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.w),
                        child: Divider(color: UtilColors.lightGrey),
                      ),
                      AppButton(
                        title: 'Сохранить',
                        isRound: true,
                        onTap: controller.addMovement,
                        isActive:
                            controller.selectedTimeStart.value != null && controller.selectedTimeEnd.value != null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String title, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(color: UtilColors.mainRed, borderRadius: BorderRadius.all(Radius.circular(3.w))),
        child: Center(
          child: Text(title, style: UtilTextStyles.termOfUseTitle.merge(TextStyle(fontSize: 30.sp, height: 0.9))),
        ),
      ),
    );
  }
}
