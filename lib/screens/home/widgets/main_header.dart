import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class MainHeader extends StatelessWidget {
  final String dateOfBirth;
  final String beforeBirth;
  final String gestationalAge;
  final int days;

  const MainHeader({
    required this.dateOfBirth,
    required this.beforeBirth,
    required this.gestationalAge,
    required this.days,
    Key? key,
  }) : super(key: key);

  double getProgress() => days / UtilRepo.pregnancyDuration;

  double getOffsetY(double width) =>
      sqrt(pow(Get.size.width / 1.15 + 5.w, 2) -
          pow(((Get.size.width - 30.w) * getProgress() + 15.w - Get.size.width / 2).abs(), 2)) -
      15.w;

  @override
  Widget build(BuildContext context) {
    double _height = Get.size.width * 1.1;
    return Container(
      height: _height + Get.mediaQuery.padding.top,
      color: UtilColors.lightOrange,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          Positioned(
            bottom: 0, // Get.size.width / 1.44,
            child: Container(
              color: UtilColors.mainScaffoldGrey,
              child: Container(
                width: Get.size.width - 30.w,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: Get.size.width / 4.75),
                    Text(
                      '2 триместр',
                      style: UtilTextStyles.calendarWeek.merge(const TextStyle(fontWeight: FontWeight.w400)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listItem('Мой срок:', gestationalAge),
                        SizedBox(width: 40.w),
                        listItem('Дата родов:', dateOfBirth, offset: Get.size.width / 20),
                        SizedBox(width: 40.w),
                        listItem('До родов:', beforeBirth.isEmpty ? 'Совсем немного' : beforeBirth),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: ClippingTop(),
            child: Row(
              children: [
                Container(
                  width: (Get.size.width - 30.w) * getProgress() + 15.w,
                  color: UtilColors.borderOrange,
                ),
                Container(
                  width: (Get.size.width - 30.w) * (1 - getProgress()),
                  color: Colors.white,
                ),
                if (Get.size.width - getProgress() - 15.w > 0) SizedBox(width: 15.w),
              ],
            ),
          ),
          ClipPath(
            clipper: ClippingTopIcon(),
            child: Container(
              width: Get.size.width,
              height: _height * .8,
              color: UtilColors.mainHeaderBg,
              padding: EdgeInsets.only(bottom: 5.w),
              child: FittedBox(fit: BoxFit.fill, child: UtilIcons(UtilIcons.headerBg)),
            ),
          ),
          Positioned(
            top: _height * .74,
            left: Get.size.width / 7 * 2,
            child: Transform.rotate(angle: pi / 10, child: Container(color: Colors.white, width: 2.w, height: 13.w)),
          ),
          Positioned(
            top: _height * .74,
            left: Get.size.width / 7 * 5,
            child: Transform.rotate(angle: -pi / 10, child: Container(color: Colors.white, width: 2.w, height: 13.w)),
          ),
          Positioned(
            top: _height * .76,
            left: Get.size.width / 7 * 0.5,
            child: Transform.rotate(
              angle: pi / 8,
              child: Text(
                '1 триместр',
                style: UtilTextStyles.calendarWeek.merge(const TextStyle(fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Positioned(
            top: _height * .76,
            right: Get.size.width / 7 * 0.5,
            child: Transform.rotate(
              angle: -pi / 8,
              child: Text(
                '3 триместр',
                style: UtilTextStyles.calendarWeek.merge(const TextStyle(fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Positioned(
            top: getOffsetY(Get.size.width - 30.w),
            left: (Get.size.width - 30.w) * getProgress() + 7.5.w,
            child: Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(shape: BoxShape.circle, color: UtilColors.mainRed),
            ),
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 5.w, bottom: 15.w), child: weekRow()),
              const Spacer(),
              SizedBox(
                height: _height * .7,
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        left: Get.size.width / 18,
                        top: 10,
                        child: UtilIcons(UtilIcons.baby(days ~/ 30 == 0 ? 1 : days ~/ 30), width: Get.width * .35),
                      ),
                      Positioned(
                        top: 0,
                        right: Get.size.width / 7,
                        child: Stack(
                          children: [
                            UtilIcons(UtilIcons.headerText, height: Get.width * .14),
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  'Привет, мамочка!\n',
                                  style: UtilTextStyles.dropDownTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: Get.width * .16,
                        left: Get.size.width / 18 + Get.width * .38,
                        child: SizedBox(
                          width: Get.size.width - Get.size.width / 18 - Get.width * .45,
                          child: Text(UtilRepo.babyDescription[days ~/ 30 > 8 ? 8 : days ~/ 30],
                              style: UtilTextStyles.titleDescription),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(height: 25.w),
            ],
          ),
        ],
      ),
    );
  }

  Widget listItem(String name, String value, {double offset = 0.0}) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: offset),
          Text(name, style: UtilTextStyles.greyTextDesc.merge(TextStyle(fontSize: Get.size.width / 40))),
          SizedBox(height: 5.w),
          Text(value,
              style: UtilTextStyles.dropDownTitle.merge(TextStyle(fontSize: Get.size.width / 30)),
              textAlign: TextAlign.center),
          SizedBox(height: 10.w),
        ],
      ),
    );
  }

  Widget weekRow() {
    int weeks = days ~/ 7;
    int start = weeks + 6 > 42 ? 34 : weeks - 3;
    List<int> list = List<int>.generate(9, (i) => start + i);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: list.map((e) => weekItem(e, e < days ~/ 7, e == days ~/ 7)).toList(),
    );
  }

  Widget weekItem(int weekIndex, bool active, bool current) {
    return Container(
      height: (Get.size.width - 72.w) / 9,
      width: (Get.size.width - 72.w) / 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: active ? UtilColors.borderOrange : Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: CustomPaint(
        foregroundPainter: MyPainter(
          lineColor: UtilColors.disabled,
          completeColor: UtilColors.borderOrange,
          width: 2.w,
          completePercent: active
              ? 100
              : current
                  ? days % 7 / 7 * 100
                  : 0,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              weekIndex.toString(),
              style: UtilTextStyles.weekItemTitle.merge(
                TextStyle(
                  color: active
                      ? Colors.white
                      : current
                          ? UtilColors.darkGrey
                          : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  MyPainter({required this.lineColor, required this.completeColor, required this.completePercent, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ClippingTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, 0), radius: Get.size.width / 1.15));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClippingTopIcon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, 0), radius: Get.size.width / 1.15 - 5.w));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
