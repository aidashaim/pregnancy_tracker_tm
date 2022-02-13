import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracker_tm/screens/add_note_and_doctor/add_note_and_doctor_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';
import 'package:pregnancy_tracker_tm/widgets/main_list_item.dart';

class AddNoteAndDoctorScreen extends GetView<AddNoteAndDoctorController> {
  final bool isNote;

  const AddNoteAndDoctorScreen({this.isNote = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                BackButtonWithTitle(title: isNote ? 'Заметка' : 'Приём к врачу'),
                SizedBox(height: 5.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UtilIcons(UtilIcons.calendar, height: 30.w),
                            SizedBox(width: 15.w),
                            Text(
                              DateFormat('dd MMMM yyyy HH:mm').format(controller.selectedDay.value),
                              style: UtilTextStyles.priceTitle,
                            ),
                            InkWell(
                              onTap: controller.editDateTime,
                              child: Padding(
                                padding: EdgeInsets.all(15.w),
                                child: UtilIcons(UtilIcons.edit, height: 30.w),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.w),
                        AppTextField.large(
                            hint: isNote ? 'Текст заметки' : 'Имя врача, адрес, кабинет',
                            controller: controller.noteTextController),
                        SizedBox(height: 20.w),
                        MainListItem(
                          title: 'Напоминание',
                          onTap: () {},
                          child: SizedBox(
                            height: 25.w,
                            child: Switch(
                              value: controller.notification.value,
                              onChanged: (value) => controller.changeNotification(value),
                              activeColor: UtilColors.mainRed,
                              activeTrackColor: UtilColors.lightRed,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Divider(color: UtilColors.lightGrey),
                        ),
                        if (controller.notification.value) ...[
                          MainListItem(
                            title: 'Время напоминания',
                            onTap: controller.selectTimes,
                            child: controller.selectedTimesTitles.isEmpty
                                ? Text('Выбрать', style: UtilTextStyles.dropDownTitle)
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: controller.selectedTimesTitles
                                        .map((e) => Text(e, style: UtilTextStyles.dropDownTitle))
                                        .toList()),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.w),
                            child: Divider(color: UtilColors.lightGrey),
                          ),
                        ],
                        AppButton(
                          title: 'Сохранить',
                          isRound: true,
                          onTap: controller.add,
                          isActive: controller.text.isNotEmpty,
                        ),
                        SizedBox(height: 20.w),
                      ],
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
}
