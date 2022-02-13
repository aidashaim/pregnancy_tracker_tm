import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/weekly_advice_group_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:dotted_border/dotted_border.dart';

class WeeklyAdvices extends StatelessWidget {
  final List<WeeklyAdviceGroupModel> advices;
  final Function onTap;

  const WeeklyAdvices({required this.advices, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Советы на неделю', style: UtilTextStyles.moodTitle),
      SizedBox(height: 15.w),
      Row(
        children: List<Widget>.generate(
          3,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: adviceListItem(
              img: advices[index].img,
              title: advices[index].title,
              isShown: advices[index].isShown,
            ),
          ),
        ),
      )
    ]);
  }

  Widget adviceListItem({required String img, required String title, bool isShown = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),//(Get.size.width - 66.w) / 24),
      child: Column(
        children: [
          DottedBorder(
            color: isShown ? Colors.transparent : UtilColors.mainOrange,
            strokeWidth: 2.w,
            dashPattern: [6.w, 4.w],
            borderType: BorderType.RRect,
            radius: Radius.circular(24.w),
            padding: EdgeInsets.all(4.w),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
              child: Image.asset(img, width: (Get.size.width - 114.w) / 3, height: (Get.size.width - 126.w) / 3 * .92),
            ),
          ),
          SizedBox(height: 12.w),
          Text(title, style: UtilTextStyles.dropDownTitle),
        ],
      ),
    );
  }
}
