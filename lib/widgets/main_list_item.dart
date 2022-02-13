import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class MainListItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final String? icon;
  final Color? color;
  final Widget? child;

  const MainListItem({
    required this.title,
    required this.onTap,
    this.icon,
    this.color,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Row(
        mainAxisAlignment: child != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: UtilIcons(icon!, width: 24.w, color: color),
            ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Text(title, style: UtilTextStyles.dropDownTitle),
            ),
          ),
          if (child != null) Expanded(
              flex: 3,
              child: Align(alignment: Alignment.centerRight, child: child!)),
        ],
      ),
    );
  }
}
