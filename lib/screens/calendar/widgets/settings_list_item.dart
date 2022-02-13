import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class SettingsListItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final String? icon;
  final Color? color;
  final Widget? child;

  const SettingsListItem({
    required this.title,
    required this.onTap,
    this.icon,
    this.color,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: child != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: UtilIcons(icon!, width: 24.w, color: color),
          ),
        //Expanded(
        //flex: 3,
        //child:
        Text(title, style: UtilTextStyles.dropDownTitle),
        //),
        if (child != null) child!,
      ],
    );
  }
}
