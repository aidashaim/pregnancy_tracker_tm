import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/i_gave_birth/i_gabe_birth_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';

class IGabeBirthScreen extends GetView<IGabeBirthController> {
  const IGabeBirthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.redBg,
      body: SizedBox(
        width: Get.size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(top: 0, child: UtilIcons(UtilIcons.bgIcon, width: Get.size.width)),
            Positioned(
              top: 20.w,
              left: 0.w,
              right: 0.w,
              child: UtilIcons(UtilIcons.logoBirth, width: Get.size.width * .9),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(flex: 10),
                    Text(
                      'Поздравляем Вас \nс рождением малыша!',
                      style: UtilTextStyles.splashTitle,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(flex: 1),
                    // временно скрыто
                    /*Text(
                      'Тут текст, типа “поздравляем Вас с новым этапом в вашей жизни. дети-чудо, желаем вам '
                      'бла бла бла, спасибо, что воспользовались нашим приложением. Мы крайне признательны.'
                      '\n\nПредлагаем Вам наше новое предложение ',
                      style: UtilTextStyles.buttonTitle,
                    ),
                    const Spacer(flex: 2),
                    AppButton(
                      title: 'Скачать приложение',
                      bgColor: UtilColors.mainOrange,
                      onTap: () {},
                    ),*/
                    SizedBox(height: 8.w),
                    AppButton(title: 'Закрыть', onTap: () => Get.back(), bgColor: Colors.white.withOpacity(.25)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
