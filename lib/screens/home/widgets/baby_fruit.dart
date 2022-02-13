import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class BabyFruit extends StatelessWidget {
  BabyFruit({Key? key}) : super(key: key);
  final int week = userRepository.currentUser.currentWeek - 1;

  double getTextHeight(String text, TextStyle style, {double? maxWidth}) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: maxWidth ?? double.infinity);
    return textPainter.size.height;
  }

  double getAllHeight() {
    return 44.w +
        getTextHeight('Ваш малыш как:', UtilTextStyles.greyTextDesc) +
        getTextHeight(UtilRepo.babyFruit[week], UtilTextStyles.moodTitle) +
        getTextHeight('Норма ЧСС', UtilTextStyles.greyTextDesc) +
        getMaxItemsHeight();
  }

  double getMaxItemsHeight() {
    double f = getTextHeight(
      UtilRepo.babyGrowth[week],
      UtilTextStyles.dropDownTitle,
      maxWidth: (Get.size.width - 70.w) / 3 * 2,
    );
    double s = getTextHeight(
      UtilRepo.babyWeight[week],
      UtilTextStyles.dropDownTitle,
      maxWidth: (Get.size.width - 70.w) / 3 * 2,
    );
    double t = getTextHeight(
      UtilRepo.babyCHSS[week],
      UtilTextStyles.dropDownTitle,
      maxWidth: (Get.size.width - 70.w) / 3 * 2,
    );
    return <double>[f, s, t].reduce((curr, next) => curr > next ? curr : next);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: getAllHeight(),
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
      child: Row(
        children: [
          Expanded(flex: 2, child: UtilIcons(UtilIcons.week(week + 1))),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ваш малыш как:', style: UtilTextStyles.greyTextDesc),
                SizedBox(height: 2.w),
                Text(UtilRepo.babyFruit[week], style: UtilTextStyles.moodTitle),
                SizedBox(height: 8.w),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (UtilRepo.babyGrowth[week].isNotEmpty) ...[
                        Expanded(child: babyParameterItem('Рост плода', UtilRepo.babyGrowth[week])),
                        Container(
                          color: UtilColors.lightGrey,
                          width: 1.w,
                          height: Get.size.height,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                        ),
                      ],
                      if (UtilRepo.babyWeight[week].isNotEmpty) ...[
                        Expanded(child: babyParameterItem('Вес плода', UtilRepo.babyWeight[week])),
                        Container(
                          color: UtilColors.lightGrey,
                          width: 1.w,
                          height: Get.size.height,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                        ),
                      ],
                      if (UtilRepo.babyCHSS[week].isNotEmpty) ...[
                        Expanded(child: babyParameterItem('Норма ЧСС', UtilRepo.babyCHSS[week])),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget babyParameterItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(child: Text(title, style: UtilTextStyles.greyTextDesc)),
        SizedBox(height: 4.w),
        FittedBox(child: Text(value, style: UtilTextStyles.dropDownTitle, maxLines: 1)),
      ],
    );
  }
}
