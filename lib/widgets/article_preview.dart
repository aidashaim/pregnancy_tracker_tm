import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class ArticlePreview extends StatelessWidget {
  final dynamic article;
  final Function onTap;
  final Function? onSavedTap;
  final int? dateOffset;

  const ArticlePreview({
    required this.article,
    required this.onTap,
    this.onSavedTap,
    this.dateOffset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(article),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
        child: Column(
          children: [
            Stack(
              children: [
                article.img.isNotEmpty
                    ? Image.network(article.img, width: double.infinity, height: 150.w, fit: BoxFit.cover)
                    : SizedBox(height: 150.w),
                Positioned(
                  right: 15.w,
                  top: 15.w,
                  child: InkWell(
                    onTap: () => onSavedTap?.call(article),
                    child: Container(
                      padding: EdgeInsets.all(7.w),
                      width: 36.w,
                      height: 36.w,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: FittedBox(
                        child: UtilIcons(UtilIcons.saved, color: article.isSaved ? UtilColors.savedYellow : null),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        UtilFormatters.dayMonth(DateTime.now().subtract(Duration(days: dateOffset ?? 0))),
                        style: UtilTextStyles.greyText,
                      ),
                      if (article is DailyAdviceModel)
                        Text('${article.day.toString()} день', style: UtilTextStyles.greyText),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Text(article.title, style: UtilTextStyles.dropDownTitle, maxLines: 2, textAlign: TextAlign.start),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
