import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class BackButtonWithTitle extends StatelessWidget {
  final String title;
  final Function? onTap;
  final bool isWhite;
  final bool needInfo;

  const BackButtonWithTitle({
    required this.title,
    this.onTap,
    this.isWhite = false,
    this.needInfo = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onTap != null ? onTap!.call() : Get.back(),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: UtilIcons(UtilIcons.arrowBack, width: 22.w, color: isWhite ? Colors.white : null),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: isWhite ? UtilTextStyles.whiteTitle : UtilTextStyles.priceTitle),
              if (needInfo)
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: UtilIcons(UtilIcons.info, height: 30.w),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
