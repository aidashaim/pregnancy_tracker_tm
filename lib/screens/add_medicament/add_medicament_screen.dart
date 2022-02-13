import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/add_medicament/add_medicament_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dropdown_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/main_list_item.dart';

class AddMedicamentScreen extends GetView<AddMedicamentController> {
  const AddMedicamentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const BackButtonWithTitle(title: 'Приём медикаментов'),
              SizedBox(height: 5.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    children: [
                      SizedBox(height: 15.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15.w),
                          Text(controller.name.value, style: UtilTextStyles.priceTitle),
                          InkWell(
                            onTap: controller.setName,
                            child: Padding(
                              padding: EdgeInsets.all(15.w),
                              child: UtilIcons(UtilIcons.edit, height: 30.w),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: UtilColors.lightGrey),
                      SizedBox(height: 15.w),
                      listItem('Тип', controller.type, controller.typeItems),
                      listItemText('Дозировка', controller.dosageTextController, subtitle: 'шт.'),
                      listItemText(
                        'Количество раз в день',
                        controller.countTextController,
                        isNumber: true,
                      ),
                      listItem('Периодичность', controller.period, controller.periodItems),
                      listItem('Рацион', controller.diet, controller.dietItems),
                      listItemText('Длительность', controller.durationTextController, subtitle: 'дн.', isNumber: true),
                      InkWell(
                        onTap: controller.selectDate,
                        child: IgnorePointer(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Column(
                              children: [
                                MainListItem(
                                  title: 'Начать с',
                                  onTap: () {},
                                  child: AppDropdownButton(
                                    onChange: (String value) {},
                                    isExpanded: false,
                                    selected: UtilFormatters.dayMonth(controller.dateStart.value),
                                    values: [UtilFormatters.dayMonth(controller.dateStart.value)],
                                  ),
                                ),
                                divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Время приёма', style: UtilTextStyles.dropDownTitle),
                            SizedBox(height: 15.w),
                            GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.selectedTimes.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.w,
                                childAspectRatio: 2.5,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  timeItem(controller.selectedTimes[index]),
                            ),
                            SizedBox(height: 20.w),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.size.width,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: UtilColors.greyBg,
                          border: Border.all(color: UtilColors.lightGrey),
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: MainListItem(
                          title: 'Напоминание',
                          onTap: () {},
                          child: SizedBox(
                            height: 25.w,
                            child: Switch(
                              value: controller.notification.value,
                              onChanged: (value) {
                                controller.notification.value = value;
                              },
                              activeColor: UtilColors.mainRed,
                              activeTrackColor: UtilColors.lightRed,
                            ),
                          ),
                        ),
                      ),
                      divider(),
                      AppButton(
                        title: 'Сохранить',
                        isRound: true,
                        onTap: controller.add,
                        isActive: controller.buttonActive.value,
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

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.w),
      child: Divider(color: UtilColors.lightGrey),
    );
  }

  Widget listItem(String title, RxString selected, List<String> items) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Column(
        children: [
          MainListItem(
            title: title,
            onTap: () {},
            child: AppDropdownButton(
              onChange: (String value) => selected.value = value,
              isExpanded: false,
              selected: selected.value,
              values: items,
            ),
          ),
          divider(),
        ],
      ),
    );
  }

  Widget listItemText(String title, TextEditingController textController, {String? subtitle, bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Text(title, style: UtilTextStyles.dropDownTitle),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppTextField(
                    withBorder: true,
                    controller: textController,
                    type: TextInputType.number,
                    inputFormatters: isNumber
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ]
                        : null,
                  ),
                ),
              ),
              if (subtitle != null) ...[SizedBox(width: 15.w), Text(subtitle, style: UtilTextStyles.dropDownTitle)],
            ],
          ),
          divider(),
        ],
      ),
    );
  }

  Widget timeItem(TimeOfDay time) {
    return InkWell(
      onTap: () => controller.selectTime(time),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
        decoration: BoxDecoration(
          color: UtilColors.navigationGrey.withOpacity(.37),
          borderRadius: BorderRadius.circular(100.w),
        ),
        child: Center(child: Text(UtilFormatters.time(time), style: UtilTextStyles.dropDownTitle)),
      ),
    );
  }
}
