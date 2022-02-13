import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/contraction_counter_model.dart';
import 'package:pregnancy_tracker_tm/screens/contraction_counter/contraction_counter_controller.dart';
import 'package:pregnancy_tracker_tm/screens/contraction_counter/widgets/contraction_counter_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class ContractionCounterScreen extends GetView<ContractionCounterController> {
  const ContractionCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const BackButtonWithTitle(title: 'Счётчик схваток', needInfo: true),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 170.w,
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: controller.contractionStarted.value ? UtilColors.mainRed : Colors.white,
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                        ),
                        UtilIcons(UtilIcons.circles, height: 170.w),
                        SizedBox(
                          height: 170.w,
                          child: Column(
                            children: [
                              SizedBox(height: 40.w),
                              Text(
                                controller.timerContractionText.value,
                                style: UtilTextStyles.timerTitle.merge(
                                  TextStyle(color: controller.contractionStarted.value ? Colors.white : null),
                                ),
                              ),
                              SizedBox(height: 5.w),
                              Text(
                                controller.timerIntervalText.value,
                                style: UtilTextStyles.timerSubtitle.merge(
                                  TextStyle(
                                    color: controller.contractionStarted.value ? Colors.white.withOpacity(.75) : null,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.w),
                              AppButton(
                                title: controller.contractionStarted.value ? 'Стоп' : 'Схватка',
                                isRound: true,
                                bgColor: controller.contractionStarted.value ? Colors.white : UtilColors.mainRed,
                                titleColor: controller.contractionStarted.value ? UtilColors.darkGrey : Colors.white,
                                onTap: () => controller.contractionStarted.value
                                    ? controller.stopContraction()
                                    : controller.startContraction(),
                              ),
                              SizedBox(height: 20.w),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                      child: ContractionCounterItem(
                        contraction: ContractionCounterModel(
                          start: 'Начало',
                          end: 'Окончание',
                          duration: 'Длительность',
                          interval: 'Интервал',
                        ),
                        isTitle: true,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.contractions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        color: index % 2 == 0 ? Colors.white : Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: ContractionCounterItem(contraction: controller.contractions[index]),
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
}
