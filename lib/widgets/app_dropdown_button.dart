import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class AppDropdownButton extends StatelessWidget {
  final Function(String) onChange;
  final List<String> values;
  final String? selected;
  final String? hint;
  final bool isExpanded;

  const AppDropdownButton({
    required this.onChange,
    required this.values,
    required this.selected,
    this.hint,
    this.isExpanded = true,
    Key? key,
  }) : super(key: key);

  double getTextWidth() {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: selected, style: UtilTextStyles.dropDownTitle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0.w, maxWidth: Get.mediaQuery.size.width);
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hint != null)
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Text(hint!, style: UtilTextStyles.dropDownHint),
          ),
        Container(
          width: isExpanded ? double.maxFinite : Get.size.width / 1.5,
          height: isExpanded ? 48.w : 25.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : null,
            borderRadius: BorderRadius.circular(isExpanded ? 12.w : 0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selected,
              onChanged: (String? value) {
                if (value != null) onChange(value);
              },
              items: values
                  .map(
                    (item) => DropdownMenuItem(
                        alignment: Alignment.topLeft,
                        value: item,
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.fromLTRB(10.w, 14.w, 10.w, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: item == values.first ? Colors.transparent : UtilColors.lightGrey,
                              ),
                            ),
                          ),
                          child: Text(item, style: UtilTextStyles.dropDownTitle, maxLines: 1),
                        )),
                  )
                  .toList(),
              selectedItemBuilder: (context) => values
                  .map((item) => Row(
                        mainAxisAlignment: isExpanded ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          Flexible(
                              //fit: BoxFit.scaleDown,
                              child: Text(item, style: UtilTextStyles.dropDownTitle, maxLines: 1)),
                        ],
                      ))
                  .toList(),
              isExpanded: true,
              icon: Padding(padding: EdgeInsets.only(left: 5.w), child: UtilIcons(UtilIcons.arrowDown, width: 10.w)),
              borderRadius: BorderRadius.circular(12.w),
            ),
          ),
        ),
      ],
    );
  }
}
