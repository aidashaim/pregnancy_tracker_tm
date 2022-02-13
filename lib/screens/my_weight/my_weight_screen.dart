import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/models/weight_unit.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/screens/my_weight/my_weight_controller.dart';
import 'package:pregnancy_tracker_tm/screens/my_weight/widgets/my_weight_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pregnancy_tracker_tm/widgets/back_button.dart';

class MyWeightScreen extends GetView<MyWeightController> {
  const MyWeightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.greyBg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const BackButtonWithTitle(title: 'Мой вес', needInfo: true),
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Stack(
                              children: [
                                UtilIcons(UtilIcons.myWeight, width: Get.size.width - 120.w),
                                if (controller.currentWeight.value != '-')
                                  Positioned(
                                    bottom: (Get.size.width - 120.w) / 10,
                                    left: 0,
                                    right: 0,
                                    child: weightValues(),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.w),
                          Text('Ваш вес', style: UtilTextStyles.greyTextDesc),
                          SizedBox(height: 3.w),
                          Text(controller.currentWeight.value, style: UtilTextStyles.dialogTitle),
                          SizedBox(height: 15.w),
                          AppButton(title: 'Добавить значение', isRound: true, onTap: controller.addWeight),
                          SizedBox(height: 15.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Expanded(child: rowItem('Вес до беременности', controller.startWeight.value)),
                          SizedBox(width: 8.w),
                          Expanded(child: rowItem('Текущий \nвес', controller.currentWeight.value)),
                          SizedBox(width: 8.w),
                          Expanded(child: rowItem('Общая прибавка в весе', controller.totalIncrease.value)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        children: [
                          Expanded(child: rowItem2('Средняя прибавка', UtilColors.chartYellow)),
                          SizedBox(width: 20.w),
                          Expanded(child: rowItem2('Фактический вес', UtilColors.mainRed.withOpacity(.75))),
                        ],
                      ),
                    ),
                    if (controller.weights.isNotEmpty) ...[
                      chart(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                        child: rowTitle(),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.weights.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          color: index % 2 == 0 ? Colors.white : Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.w),
                          child: MyWeightItem(weight: controller.weights[index]),
                        ),
                      ),
                    ],
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

  Widget rowItem2(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 35.w,
          height: 5.w,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.w)),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(title, style: UtilTextStyles.greyTextDesc)),
      ],
    );
  }

  Widget weightValues() {
    List<int> leftList = List<int>.generate(3, (i) => controller.currentWeightInt.value - 3 + i);
    List<int> rightList = List<int>.generate(3, (i) => controller.currentWeightInt.value + 1 + i);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (Get.size.width - 120.w) / 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: (Get.size.width - 120.w) / 15),
              child: Transform.rotate(
                angle: pi / 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...leftList.map((e) => Text(e.toString(), style: UtilTextStyles.greyTextDesc)).toList(),
                  ],
                ),
              ),
            ),
          ),
          Text(controller.currentWeightInt.value.toString(), style: UtilTextStyles.priceSubtitle),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: (Get.size.width - 120.w) / 15),
              child: Transform.rotate(
                angle: -pi / 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...rightList.map((e) => Text(e.toString(), style: UtilTextStyles.greyTextDesc)).toList(),
                  ],
                ),
              ),
            ),
          ),
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
              interval: userRepository.currentUser.weightUnits == WeightUnit.kilogram  ?  10 : 22,
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
            if (controller.firstWeight != null)
              LineChartBarData(
                colors: [UtilColors.chartYellow],
                barWidth: 3.w,
                dotData: FlDotData(show: false),
                spots: [
                  FlSpot(0, controller.firstWeight!),
                  FlSpot(2 * 7, controller.firstWeight! + 0.5),
                  FlSpot(4 * 7, controller.firstWeight! + 0.7),
                  FlSpot(6 * 7, controller.firstWeight! + 1.0),
                  FlSpot(8 * 7, controller.firstWeight! + 1.2),
                  FlSpot(10 * 7, controller.firstWeight! + 1.3),
                  FlSpot(12 * 7, controller.firstWeight! + 1.5),
                  FlSpot(14 * 7, controller.firstWeight! + 1.9),
                  FlSpot(16 * 7, controller.firstWeight! + 2.3),
                  FlSpot(18 * 7, controller.firstWeight! + 3.6),
                  FlSpot(20 * 7, controller.firstWeight! + 4.8),
                  FlSpot(22 * 7, controller.firstWeight! + 5.7),
                  FlSpot(24 * 7, controller.firstWeight! + 6.4),
                  FlSpot(26 * 7, controller.firstWeight! + 7.7),
                  FlSpot(28 * 7, controller.firstWeight! + 8.2),
                  FlSpot(30 * 7, controller.firstWeight! + 9.1),
                  FlSpot(32 * 7, controller.firstWeight! + 10.0),
                  FlSpot(34 * 7, controller.firstWeight! + 10.9),
                  FlSpot(36 * 7, controller.firstWeight! + 11.8),
                  FlSpot(38 * 7, controller.firstWeight! + 12.7),
                  FlSpot(40 * 7, controller.firstWeight! + 13.6),
                  FlSpot(42 * 7, controller.firstWeight! + 14.5),
                ],
              ),
            LineChartBarData(
              colors: [UtilColors.mainRed.withOpacity(.75)],
              barWidth: 3.w,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) =>
                    FlDotCirclePainter(radius: 3.w, color: UtilColors.mainRed, strokeColor: Colors.transparent),
              ),
              spots: [
                if (controller.firstWeight != null) FlSpot(0, controller.firstWeight!),
                ...controller.weights.map((weight) => FlSpot(weight.days, weight.value)).toList()
              ],
            ),
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
        Expanded(flex: 2, child: Text('Вес', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
        Expanded(flex: 2, child: Text('Прибавка', textAlign: TextAlign.center, style: UtilTextStyles.greyTextDesc)),
      ],
    );
  }
}
