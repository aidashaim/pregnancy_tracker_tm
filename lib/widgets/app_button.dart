import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isActive;
  final Color? bgColor;
  final bool isRound;
  final Color? titleColor;
  final MainAxisAlignment buttonAlign;

  const AppButton({
    required this.title,
    this.onTap,
    this.isActive = true,
    this.bgColor,
    this.isRound = false,
    this.titleColor,
    this.buttonAlign = MainAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRound ? Row(mainAxisAlignment: buttonAlign, children: [buttonWidget()]) : buttonWidget();
  }

  Widget buttonWidget() {
    return InkWell(
      borderRadius: BorderRadius.circular(25.w),
      onTap: () => isActive ? onTap?.call() : null,
      splashColor: Colors.transparent,
      child: Container(
        width: isRound ? null : Get.size.width,
        height: isRound ? 32.w : 48.w,
        decoration: BoxDecoration(
          color: bgColor ?? (isActive ? UtilColors.mainRed : UtilColors.disabled),
          borderRadius: BorderRadius.circular(isRound ? 100.w : 12.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: isRound ? 30.w : 15.w),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: UtilTextStyles.buttonTitle.merge(TextStyle(color: titleColor)),
            ),
          ),
        ),
      ),
    );
  }
}
