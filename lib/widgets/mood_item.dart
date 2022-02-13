import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/mood_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';

class MoodItem extends StatelessWidget {
  final MoodModel mood;
  final Function onTap;

  const MoodItem({required this.mood, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: (Get.size.width - 66.w) / (MoodModel.allMoods.length + 1),
        padding: EdgeInsets.all(5.w),
        margin: EdgeInsets.symmetric(horizontal: (Get.size.width - 66.w) / (MoodModel.allMoods.length + 1) / 12),
        decoration: BoxDecoration(color: UtilColors.mediumGrey, shape: BoxShape.circle),
        child: UtilIcons(MoodModel.mapIcons[mood.stringCode]!, width: 40.w),
      ),
    );
  }
}
