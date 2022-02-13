import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker_tm/screens/splash/splash_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.blueBg,
      body: Stack(
        children: [
          Column(),
          UtilIcons(UtilIcons.bgIcon, width: Get.size.width),
          Positioned(
            bottom: Get.size.height * .02,
            left: Get.size.width * .15,
            child: UtilIcons(UtilIcons.splashLogoBottom, height: Get.size.height * .25),
          ),
          Positioned(
            top: Get.size.height * .05,
            left: 0,
            right: 0,
            child: UtilIcons(UtilIcons.splashLogo, width: Get.size.height * .45),
          ),
          Positioned(
            top: Get.size.height * .45,
            left: 0,
            right: 0,
            child: Center(
              child: Text('Добро\nпожаловать!', style: UtilTextStyles.splashTitle, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
