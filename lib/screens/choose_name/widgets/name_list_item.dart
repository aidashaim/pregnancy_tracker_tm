import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:pregnancy_tracker_tm/models/name_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class NameListItem extends StatelessWidget {
  final NameModel name;
  final Function saveNameTap;

  const NameListItem({required this.name, required this.saveNameTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => saveNameTap.call(name),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UtilIcons(UtilIcons.saved, width: 24.w, color: name.isSaved ? UtilColors.savedYellow : null),
            SizedBox(width: 18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name.name, style: UtilTextStyles.moodTitle),
                  if (name.meaning != null)
                    Text(name.meaning?.capitalizeFirst ?? '', style: UtilTextStyles.titleDescription),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
