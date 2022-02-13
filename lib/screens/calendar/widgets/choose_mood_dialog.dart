import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:pregnancy_tracker_tm/widgets/mood_item.dart';

class ChooseMoodDialog extends StatelessWidget {
  const ChooseMoodDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          child: Container(
            width: Get.size.width,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.all(25.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.w))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Выбрать настроение:', style: UtilTextStyles.priceTitle),
                SizedBox(height: 35.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...MoodModel.allMoods
                        .map((mood) => MoodItem(mood: mood, onTap: () => Get.back(result: mood)))
                        .toList()
                  ],
                ),
                SizedBox(height: 35.w),
                AppButton(
                  title: 'Отменить',
                  bgColor: UtilColors.geryBlue,
                  titleColor: Colors.white,
                  isRound: true,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
