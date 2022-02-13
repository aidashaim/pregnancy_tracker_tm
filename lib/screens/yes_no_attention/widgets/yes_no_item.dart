import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class YesNoItem extends StatelessWidget {
  final CanOrCantModel canOrCant;
  final Function onTap;

  const YesNoItem({required this.canOrCant, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(canOrCant),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UtilIcons(
              canOrCant.status == '1'
                  ? UtilIcons.yes
                  : canOrCant.status == '2'
                      ? UtilIcons.attention
                      : UtilIcons.no,
              width: 24.w,
            ),
            SizedBox(width: 15.w),
            Expanded(child: Text(canOrCant.title, style: UtilTextStyles.dropDownTitle)),
          ],
        ),
      ),
    );
  }
}
