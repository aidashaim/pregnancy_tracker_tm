import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UtilIcons extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? width;
  final double? height;

  const UtilIcons(this.icon, {this.color, this.width, this.height, Key? key}) : super(key: key);


  static String get add => 'assets/icons/add.svg';
  static String get arrowBack => 'assets/icons/arrow_back.svg';
  static String get arrowDown => 'assets/icons/arrow_down.svg';
  static String get arrowLeft => 'assets/icons/arrow_left.svg';
  static String get arrowRight => 'assets/icons/arrow_right.svg';
  static String get attention => 'assets/icons/attention.svg';
  static String get beauty => 'assets/icons/beauty.svg';
  static String get bed => 'assets/icons/bed.svg';
  static String get bgIcon => 'assets/icons/blue-bg.svg';
  static String get born => 'assets/icons/born.svg';
  static String get boy => 'assets/icons/boy.svg';
  static String get calendar => 'assets/icons/calendar.svg';
  static String get calendarMenu => 'assets/icons/calendar-menu.svg';
  static String get circles => 'assets/icons/circles.svg';
  static String get close => 'assets/icons/close.svg';
  static String get comment => 'assets/icons/comment.svg';
  static String get crown => 'assets/icons/crown.svg';
  static String get delete => 'assets/icons/delete.svg';
  static String get done => 'assets/icons/done.svg';
  static String get edit => 'assets/icons/edit.svg';
  static String get fitness => 'assets/icons/fitness.svg';
  static String get food => 'assets/icons/food.svg';
  static String get foot => 'assets/icons/foot.svg';
  static String get fruit => 'assets/icons/fruit.svg';
  static String get girl => 'assets/icons/girl.svg';
  static String get headerBg => 'assets/icons/header-bg.svg';
  static String get headerText => 'assets/icons/header-text.svg';
  static String get heightIcon => 'assets/icons/height.svg';
  static String get home => 'assets/icons/home.svg';
  static String get house => 'assets/icons/house.svg';
  static String get info => 'assets/icons/info.svg';
  static String get like => 'assets/icons/like.svg';
  static String get logo => 'assets/icons/logo.svg';
  static String get logoBirth => 'assets/icons/logo-birth.svg';
  static String get logoRight => 'assets/icons/logo_right.svg';
  static String get masters => 'assets/icons/masters.svg';
  static String get mastersContractionTimer => 'assets/icons/masters-contraction-timer.svg';
  static String get mastersHospitalBag => 'assets/icons/masters-hospital-bag.svg';
  static String get mastersMyWeight => 'assets/icons/masters-my-weight.svg';
  static String get mastersName => 'assets/icons/masters-name.svg';
  static String get mastersPermitted => 'assets/icons/masters-permitted.svg';
  static String get mastersShopping => 'assets/icons/masters-shopping.svg';
  static String get mastersStirring => 'assets/icons/masters-stirring.svg';
  static String get mastersTummySize => 'assets/icons/masters-tummy-size.svg';
  static String get menu => 'assets/icons/menu.svg';
  static String get mood => 'assets/icons/mood.svg';
  static String get mood0 => 'assets/icons/mood-0.svg';
  static String get mood1 => 'assets/icons/mood-1.svg';
  static String get mood2 => 'assets/icons/mood-2.svg';
  static String get mood3 => 'assets/icons/mood-3.svg';
  static String get mood4 => 'assets/icons/mood-4.svg';
  static String get mood5 => 'assets/icons/mood-5.svg';
  static String get myWeight => 'assets/icons/my-weight.svg';
  static String get no => 'assets/icons/no.svg';
  static String get notes => 'assets/icons/notes.svg';
  static String get pacifier => 'assets/icons/pacifier.svg';
  static String get pharmacy => 'assets/icons/pharmacy.svg';
  static String get saved => 'assets/icons/saved.svg';
  static String get search => 'assets/icons/search.svg';
  static String get settings => 'assets/icons/settings.svg';
  static String get sex => 'assets/icons/sex.svg';
  static String get share => 'assets/icons/share.svg';
  static String get ship => 'assets/icons/ship.svg';
  static String get splashLogo => 'assets/icons/splash-logo.svg';
  static String get splashLogoBottom => 'assets/icons/splash-logo-bottom.svg';
  static String get star => 'assets/icons/star.svg';
  static String get stars => 'assets/icons/stars.svg';
  static String get starSaved => 'assets/icons/star-saved.svg';
  static String get tummySize => 'assets/icons/tummy-size.svg';
  static String get yes => 'assets/icons/yes.svg';
  static String get weight => 'assets/icons/weight.svg';


  static String baby(int month) => 'assets/icons/baby/baby-$month.svg';
  static String week(int week) => 'assets/icons/weeks/week-$week.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(icon, color: color, width: width, height: height);
  }
}
