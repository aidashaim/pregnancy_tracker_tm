import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/screens/login_second/login_second_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dropdown_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';

class LoginSecondScreen extends GetView<LoginSecondController> {
  const LoginSecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.blueBg,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.size.width,
            height: Get.size.height,
            child: Stack(
              children: [
                Positioned(top: 0, child: UtilIcons(UtilIcons.bgIcon, width: Get.size.width)),
                Positioned(
                  top: Get.size.height * .03,
                  left: 0,
                  child: UtilIcons(UtilIcons.logoRight, height: Get.size.height * .32),
                ),
                Positioned(
                  top: Get.size.height * .09,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Obx(
                        () => Column(
                          children: [
                            Container(
                              width: Get.size.height / 4.5,
                              height: Get.size.height / 4.5,
                              padding: EdgeInsets.all(controller.isFirstScreen.value ? 35.w : 25.w),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: UtilIcons(
                                controller.isFirstScreen.value ? UtilIcons.weight : UtilIcons.heightIcon,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              controller.isFirstScreen.value ? 'Ваш вес' : 'Размер животика',
                              style: UtilTextStyles.splashTitle,
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            buildBody(),
                            const Spacer(),
                            AppButton(
                              title: 'Пропустить',
                              bgColor: Colors.white.withOpacity(.25),
                              onTap: controller.skip,
                            ),
                            SizedBox(height: 8.w),
                            AppButton(
                              title: 'Далее',
                              onTap: controller.next,
                              isActive: controller.isButtonActive.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody() => controller.isFirstScreen.value ? firstScreen() : secondScreen();

  Widget firstScreen() {
    return Column(
      children: [
        AppTextField(
          hint: 'Не указан',
          helpText: 'Вес перед беременностью',
          type: TextInputType.number,
          controller: controller.weightBeforeTextController,
        ),
        SizedBox(height: 12.w),
        AppTextField(
          hint: 'Не указан',
          helpText: 'Текущий вес',
          type: TextInputType.number,
          controller: controller.weightCurrentTextController,
        ),
        SizedBox(height: 12.w),
        AppDropdownButton(
          hint: 'Единицы измерения',
          onChange: controller.changeWeightUnit,
          selected: controller.selectedWeightUnits.value,
          values: WeightUnit.allUnits,
        ),
      ],
    );
  }

  Widget secondScreen() {
    return Column(
      children: [
        AppTextField(
          hint: 'Не указан',
          helpText: 'Объём до беременности',
          type: TextInputType.number,
          controller: controller.heightBeforeTextController,
        ),
        SizedBox(height: 12.w),
        AppTextField(
          hint: 'Не указан',
          helpText: 'Текущий объем',
          type: TextInputType.number,
          controller: controller.heightCurrentTextController,
        ),
        SizedBox(height: 12.w),
        AppDropdownButton(
          hint: 'Единицы измерения',
          onChange: controller.changeSizeUnit,
          selected: controller.selectedSizeUnits.value,
          values: SizeUnit.allUnits,
        ),
      ],
    );
  }
}
