import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';

class AddActionDialog extends StatelessWidget {
  const AddActionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> actions = ['Заметка', 'Приём к врачу', 'Приём медикаментов', 'Настроение'];
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          child: Container(
            width: Get.size.width,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.w))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.w),
                Text('Выберите тип события:', style: UtilTextStyles.priceTitle),
                SizedBox(height: 40.w),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => actionItem(actions[index]),
                  separatorBuilder: (BuildContext context, int index) => Divider(color: UtilColors.lightGrey),
                  itemCount: actions.length,
                ),
                SizedBox(height: 40.w),
                AppButton(
                  title: 'Отменить',
                  bgColor: UtilColors.geryBlue,
                  titleColor: Colors.white,
                  isRound: true,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget actionItem(String title) {
    return InkWell(
      onTap: () => Get.back(result: title),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
              child: Text(title, style: UtilTextStyles.calendarDay),
            ),
          ),
        ],
      ),
    );
  }
}
