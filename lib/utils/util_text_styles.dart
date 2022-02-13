import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_fonts.dart';

class UtilTextStyles {
  UtilTextStyles._();

  static TextStyle get splashTitle => TextStyle(
        fontSize: 26.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get dropDownTitle => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get dropDownHint => TextStyle(
        fontSize: 12.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 16.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get buttonTitle => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.roboto,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get paywallRestore => TextStyle(
        fontSize: 12.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white.withOpacity(.9),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get advantagesTitle => TextStyle(
        fontSize: 16.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white.withOpacity(.9),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get priceSubtitle => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get priceTitle => TextStyle(
        fontSize: 18.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get whiteTitle => TextStyle(
        fontSize: 18.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get recommendedTitle => TextStyle(
        fontSize: 10.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get trialTitle => TextStyle(
        fontSize: 20.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get trialSubtitle => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get policyTitle => TextStyle(
        fontSize: 11.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get termOfUseTitle => TextStyle(
        fontSize: 12.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get moodTitle => TextStyle(
        fontSize: 16.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get greyText => TextStyle(
        fontSize: 12.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey.withOpacity(.75),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get greyTextDesc => TextStyle(
        fontSize: 10.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey.withOpacity(.75),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get dialogTitle => TextStyle(
        fontSize: 20.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get calendarDay => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get helpStyle => TextStyle(
        fontSize: 10.sp,
        fontFamily: UtilFonts.raleway,
        color: Colors.black.withOpacity(.6),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get calendarWeek => TextStyle(
        fontSize: 10.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.mainRed,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get mastersTitle => TextStyle(
        fontSize: 13.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleDescription => TextStyle(
        fontSize: 14.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey.withOpacity(.75),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get timerTitle => TextStyle(
        fontSize: 30.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get timerSubtitle => TextStyle(
        fontSize: 20.sp,
        fontFamily: UtilFonts.raleway,
        color: UtilColors.darkGrey.withOpacity(.75),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get weekItemTitle => TextStyle(
        fontSize: 13.sp,
        fontFamily: UtilFonts.raleway,
    color: UtilColors.darkGrey.withOpacity(.75),
        fontWeight: FontWeight.w500,
      );
}
