import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/size_unit.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/screens/tummy_size/tummy_size_controller.dart';
import 'package:pregnancy_tracker_tm/screens/tummy_size/widgets/tummy_size_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class TummySizeScreen extends GetView<TummySizeController> {
  const TummySizeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const BackButtonWithTitle(title: 'Размер животика', needInfo: true),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
                      child: Column(
                        children: [
                          SizedBox(height: 10.w),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Stack(
                              children: [
                                UtilIcons(UtilIcons.tummySize, width: Get.size.width - 60.w),
                                if (controller.currentSizeInt.value != 0)
                                  Positioned(
                                    bottom: (Get.size.width - 60.w) / 35,
                                    left: 0,
                                    right: 0,
                                    child: sizeValues(),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.w),
                          Text('Обхват живота', style: UtilTextStyles.greyTextDesc),
                          SizedBox(height: 3.w),
                          Text(controller.currentSize.value, style: UtilTextStyles.dialogTitle),
                          SizedBox(height: 15.w),
                          AppButton(title: 'Добавить значение', isRound: true, onTap: controller.addSize),
                          SizedBox(height: 15.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Expanded(child: rowItem('Начальный обхват', controller.startSize.value)),
                          SizedBox(width: 8.w),
                          Expanded(child: rowItem('Текущий обхват', controller.currentSize.value)),
                          SizedBox(width: 8.w),
                          Expanded(child: rowItem('Общая прибавка', controller.totalIncrease.value)),
                        ],
                      ),
                    ),
                    if (controller.sizes.isNotEmpty) ...[
                      chart(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: rowTitle(),
                      ),
                    ],
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.sizes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        color: index % 2 == 0 ? Colors.white : Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: TummySizeItem(size: controller.sizes[index]),
                      ),
                    ),
                    SizedBox(height: 15.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 15.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        children: [
          Text(title, style: UtilTextStyles.greyTextDesc, textAlign: TextAlign.center),
          SizedBox(height: 8.w),
          Text(value, style: UtilTextStyles.moodTitle),
        ],
      ),
    );
  }

  Widget sizeValues() {
    List<int> list = [];
    list = List<int>.generate(9, (i) => controller.currentSizeInt.value - 4 + i);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (Get.size.width - 60.w) / 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...list
              .map(
                (e) => Text(
                  e.toString(),
                  style:
                      e == controller.currentSizeInt.value ? UtilTextStyles.priceSubtitle : UtilTextStyles.greyTextDesc,
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget chart() {
    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 15.w, 15.w, 0),
      width: Get.size.width,
      height: 170.w,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: UtilRepo.pregnancyDuration.toDouble(),
          minY: 0,
          backgroundColor: Colors.white,
          borderData: FlBorderData(show: true, border: Border.all(color: UtilColors.lightGrey)),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              interval: userRepository.currentUser.sizeUnits == SizeUnit.centimeter ? 10 : 4,
              getTitles: (double value) => value.toStringAsFixed(0),
              getTextStyles: (_, __) => UtilTextStyles.greyTextDesc,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              interval: 28,
              getTitles: (double value) => (value ~/ 7).toStringAsFixed(0),
              getTextStyles: (_, __) => UtilTextStyles.greyTextDesc,
            ),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          ),
          gridData: FlGridData(
            verticalInterval: 28,
            horizontalInterval: 10,
            getDrawingHorizontalLine: (_) => FlLine(color: UtilColors.lightGrey, strokeWidth: 1.w),
            getDrawingVerticalLine: (_) => FlLine(color: UtilColors.lightGrey, strokeWidth: 1.w),
          ),
          lineBarsData: [
            LineChartBarData(
              colors: [UtilColors.mainRed.withOpacity(.75)],
              barWidth: 3.w,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) =>
                    FlDotCirclePainter(radius: 3.w, color: UtilColors.mainRed, strokeColor: Colors.transparent),
              ),
              spots: [
                if (controller.firstSize != null) FlSpot(0, controller.firstSize!),
                ...controller.sizes.map((size) => FlSpot(size.days, size.size)).toList()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rowTitle() {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Дата', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
        Expanded(flex: 3, child: Text('Срок', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
        Expanded(flex: 2, child: Text('Обхват', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
        Expanded(flex: 2, child: Text('Прибавка', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
      ],
    );
  }
}
