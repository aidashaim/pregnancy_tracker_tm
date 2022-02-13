import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/login/login_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dropdown_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.blueBg,
      body: Obx(
        () => Stack(
          children: [
            Column(),
            UtilIcons(UtilIcons.bgIcon, width: Get.size.width),
            Positioned(
              top: Get.size.height * .03,
              left: 0,
              right: 0,
              child: UtilIcons(UtilIcons.logo, height: Get.size.height * .35),
            ),
            Positioned(
              top: Get.size.height * .3,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  children: [
                    Text('Добро\nпожаловать!', style: UtilTextStyles.splashTitle, textAlign: TextAlign.center),
                    const Spacer(flex: 2),
                    Text('Давайте определим ваш срок', style: UtilTextStyles.subtitle),
                    const Spacer(flex: 3),
                    AppDropdownButton(
                      hint: 'Выберите способ',
                      onChange: controller.changeTiming,
                      selected: controller.selectedTiming.value,
                      values: controller.timingValues,
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: controller.selectDate,
                      child: IgnorePointer(
                        ignoring: true,
                        child: AppTextField(
                          hint: 'Указать',
                          helpText: 'Укажите срок',
                          controller: controller.gestationalAgeTextController,
                        ),
                      ),
                    ),
                    const Spacer(flex: 4),
                    Text(controller.gestationalAge.value, style: UtilTextStyles.subtitle),
                    const Spacer(flex: 6),
                    AppButton(
                      title: 'Далее',
                      isActive: controller.gestationalAge.value.isNotEmpty,
                      onTap: controller.goNext,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
