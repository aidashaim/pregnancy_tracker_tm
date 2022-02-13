import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/movement_counter/movement_counter_controller.dart';
import 'package:pregnancy_tracker_tm/screens/movement_counter/widgets/movement_counter_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class MovementCounterScreen extends GetView<MovementCounterController> {
  const MovementCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const BackButtonWithTitle(title: 'Счётчик шевелений', needInfo: true),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      height: 130.w,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      padding: EdgeInsets.fromLTRB(25.w, 0, 15.w, 20.w),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.w),
                              Text('Первое шевеление', style: UtilTextStyles.greyTextDesc),
                              SizedBox(height: 5.w),
                              Text(controller.firstMovement.value, style: UtilTextStyles.moodTitle),
                              SizedBox(height: 12.w),
                              Text('Последнее шевеление', style: UtilTextStyles.greyTextDesc),
                              Row(
                                children: [
                                  Text(controller.lastMovement.value, style: UtilTextStyles.moodTitle),
                                  if (controller.lastMovement.value.isNotEmpty)
                                    GestureDetector(
                                      onTap: controller.deleteLast,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.w),
                                        child: UtilIcons(UtilIcons.delete),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 25.w),
                          SizedBox(
                            height: 130.w,
                            width: (Get.size.width - 55.w) / 2,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 20.w,
                                  right: 50.w,
                                  child: InkWell(
                                    onTap: controller.addMovement,
                                    child: Container(
                                      padding: EdgeInsets.all(25.w),
                                      decoration: BoxDecoration(color: UtilColors.mainRed, shape: BoxShape.circle),
                                      child: UtilIcons(UtilIcons.foot),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 30.w,
                                  top: 10.w,
                                  child: Stack(
                                    children: [
                                      UtilIcons(UtilIcons.comment, height: 30.w),
                                      Positioned.fill(
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 9.w),
                                            child: Text(
                                              controller.movementCount.value.toString(),
                                              style: UtilTextStyles.subtitle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.w),
                    AppButton(title: 'Добавить вручную', isRound: true, onTap: controller.addCustomMovement),
                    SizedBox(height: 16.w),
                    if (controller.movementCounterItems.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: tableTitle(),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.movementCounterItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        color: index % 2 == 0 ? Colors.white : Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: MovementCounterItem(movement: controller.movementCounterItems[index]),
                      ),
                    ),
                    SizedBox(height: 15.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableTitle() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text('Дата', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc),
        ),
        Expanded(
          flex: 1,
          child: Text('Начало', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc),
        ),
        Expanded(
          flex: 1,
          child: Text('Окончание', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc),
        ),
        Expanded(
          flex: 2,
          child: Text('Период', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc),
        ),
        Expanded(
          flex: 1,
          child: Text('Кол-во', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc),
        ),
      ],
    );
  }
}
