import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class GridItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final String icon;

  const GridItem({required this.title, required this.onTap, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.w))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(color: UtilColors.lightOrange, shape: BoxShape.circle),
              child: Center(child: UtilIcons(icon)),
            ),
            SizedBox(height: 12.w),
            Text(title, textAlign: TextAlign.center, style: UtilTextStyles.mastersTitle),
          ],
        ),
      ),
    );
  }
}
