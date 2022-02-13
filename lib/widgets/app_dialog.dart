import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String confirmButtonTitle;
  final String description;
  final Widget? content;
  final Function? onConfirmButtonTap;

  const AppDialog({
    required this.title,
    required this.confirmButtonTitle,
    this.description = '',
    this.content,
    this.onConfirmButtonTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.w))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.w),
                Text(title, textAlign: TextAlign.center, style: UtilTextStyles.dialogTitle),
                SizedBox(height: description.isNotEmpty ? 15.w : 0),
                SizedBox(
                  width: 1.sw,
                  child: Center(
                    child: Text(description, textAlign: TextAlign.center, style: UtilTextStyles.dropDownTitle),
                  ),
                ),
                if (content != null) SizedBox(width: 1.sw, child: content!),
                SizedBox(height: 25.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      title: 'Отмена',
                      bgColor: UtilColors.navigationGrey,
                      titleColor: UtilColors.darkGrey,
                      isRound: true,
                      onTap: () => Get.back(result: false),
                    ),
                    SizedBox(width: 10.w),
                    AppButton(
                      title: confirmButtonTitle,
                      isRound: true,
                      onTap: () => onConfirmButtonTap != null ? onConfirmButtonTap!.call() : Get.back(result: true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
