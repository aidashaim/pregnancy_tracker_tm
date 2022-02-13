import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_controller.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dropdown_button.dart';
import 'package:pregnancy_tracker_tm/widgets/main_list_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.w),
            children: [
              listWidget('Аккаунт', controller.accountSettingsItems),
              SizedBox(height: 25.w),
              listWidget('Настройки', [
                MainListItem(title: 'Вес до беременности', onTap: controller.enterWeightBeforePregnancy),
                MainListItem(title: 'Объем живота до беременности', onTap: controller.enterSizeBeforePregnancy),
                MainListItem(title: 'Срок родов', onTap: controller.enterDateOfBirth),
                MainListItem(
                  title: 'Язык',
                  onTap: () {},
                  child: AppDropdownButton(
                    onChange: (String value) {},
                    isExpanded: false,
                    selected: 'Русский',
                    values: const [
                      'Русский',
                      'Английский',
                    ],
                  ),
                ),
                MainListItem(
                  title: 'Единица веса',
                  onTap: () {},
                  child: AppDropdownButton(
                    onChange: (String value) => controller.selectWeightUnits(value),
                    isExpanded: false,
                    selected: controller.selectedWeightUnits.value,
                    values: WeightUnit.allUnits,
                  ),
                ),
                MainListItem(
                  title: 'Единица длины',
                  onTap: () {},
                  child: AppDropdownButton(
                    onChange: (String value) => controller.selectSizeUnits(value),
                    isExpanded: false,
                    selected: controller.selectedTummySizeUnits.value,
                    values: SizeUnit.allUnits,
                  ),
                ),
                MainListItem(
                  title: 'Присылать уведомления?',
                  onTap: () {},
                  child: SizedBox(
                    height: 25.w,
                    child: Switch(
                      value: controller.sendNotifications.value,
                      onChanged: (value) => controller.sendNotifications.value = value,
                      activeColor: UtilColors.mainRed,
                      activeTrackColor: UtilColors.lightRed,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15.w),
              AppButton(
                title: 'Обнулить приложение',
                bgColor: UtilColors.navigationGrey,
                titleColor: UtilColors.darkGrey,
                isRound: true,
                onTap: controller.nullifyApp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listWidget(String title, List<MainListItem> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: UtilTextStyles.priceTitle),
        SizedBox(height: 15.w),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
          ),
          padding: EdgeInsets.all(20.w),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => list[index],
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 15.w),
              child: Divider(color: UtilColors.lightGrey),
            ),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}
