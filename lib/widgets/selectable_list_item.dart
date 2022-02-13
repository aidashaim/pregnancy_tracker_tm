import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:pregnancy_tracker_tm/models/selectable_list_item_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class SelectableListItem extends StatelessWidget {
  final SelectableListItemModel bagItem;
  final Function onMenuTap;
  final Function onCheckTap;

  const SelectableListItem({
    required this.bagItem,
    required this.onMenuTap,
    required this.onCheckTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => onCheckTap(bagItem),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 20.w), child: check()),
                    Expanded(
                        child:
                            Text(bagItem.value.capitalizeFirst ?? bagItem.value, style: UtilTextStyles.dropDownTitle)),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onMenuTap.call(bagItem),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
              child: UtilIcons(UtilIcons.menu),
            ),
          ),
        ],
      ),
    );
  }

  Widget check() {
    return Container(
      decoration: BoxDecoration(
        color: bagItem.isSelected ? Colors.transparent : UtilColors.textFieldGrey,
        borderRadius: BorderRadius.all(Radius.circular(3.w)),
        border: Border.all(color: bagItem.isSelected ? UtilColors.mainRed : UtilColors.navigationGrey),
      ),
      child: SizedBox(
        height: 18.w,
        width: 18.w,
        child: Theme(
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: UtilColors.mainRed,
            value: bagItem.isSelected,
            onChanged: (value) {},
          ),
          data: ThemeData(unselectedWidgetColor: Colors.transparent),
        ),
      ),
    );
  }
}
