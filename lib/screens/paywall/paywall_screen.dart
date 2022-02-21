import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:pregnancy_tracker_tm/widgets/app_button.dart';

class PaywallScreen extends GetView<PaywallController> {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilColors.redBg,
      body: Stack(
        children: [
          UtilIcons(UtilIcons.bgIcon, width: Get.size.width),
          IgnorePointer(
            ignoring: controller.isLoading.value,
            child: Padding(
              padding: EdgeInsets.all(0.w),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.w),
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.mediaQuery.padding.top),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(color: Colors.white.withOpacity(.29), shape: BoxShape.circle),
                            child: FittedBox(child: UtilIcons(UtilIcons.close)),
                          ),
                        ),
                        InkWell(
                          onTap: controller.restorePurchase,
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Text('Восстановить покупки', style: UtilTextStyles.paywallRestore),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.w),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        UtilIcons(UtilIcons.stars, width: Get.size.width - 60.w),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          width: Get.size.width / 2.5,
                          height: Get.size.width / 2.5,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: FittedBox(child: UtilIcons(UtilIcons.star)),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.w),
                    advantagesList(),
                    SizedBox(height: 15.w),
                    //const Spacer(),
                    !controller.isTrial.value ? trialWidget() : pricesWidget(),
                    SizedBox(height: 15.w),
                    //const Spacer(),
                    AppButton(
                      title: controller.isTrial.value ? 'Далее' : 'Начать',
                      bgColor: UtilColors.mainOrange,
                      onTap: controller.buyProduct,
                    ),
                    SizedBox(height: 10.w),
                    if (!controller.isAndroid.value)
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Terms of Service',
                            style:
                                UtilTextStyles.termOfUseTitle.merge(const TextStyle(decoration: TextDecoration.underline)),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' and ',
                                style:
                                    UtilTextStyles.termOfUseTitle.merge(const TextStyle(decoration: TextDecoration.none)),
                              ),
                              TextSpan(text: 'Privacy Policy', style: UtilTextStyles.termOfUseTitle),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.w),
                    Text(
                      controller.isAndroid.value
                          ? 'Вы можете управлять подпиской или отказаться от нее в любое время в настройках учетной записи Google Play'
                          : 'Отменить подписку можно в разделе “Настройки” > Apple ID в любой момент, но не менее чем за '
                              'день до даты возобновления. Подписка будет возобновляться автоматически, пока Вы ее не отмените',
                      style: UtilTextStyles.policyTitle,
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.w))),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget advantagesList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.isTrial.value ? 'В премиум версии:' : 'Хотите попробовать\nпремиум версию?',
            style: UtilTextStyles.splashTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.w),
          advantagesItem('Открыты все статьи'),
          SizedBox(height: 15.w),
          advantagesItem('Доступны все функции'),
          SizedBox(height: 15.w),
          advantagesItem('Без рекламы'),
        ],
      ),
    );
  }

  Widget pricesWidget() {
    return Column(
      children: [
        pricesItem(controller.ids[0]),
        SizedBox(height: 5.w),
        pricesItem(controller.ids[1], isRecommended: true),
        SizedBox(height: 5.w),
        pricesItem(controller.ids[2]),
      ],
    );
  }

  Widget trialWidget() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.w),
        border: Border.all(
          width: 2,
          color: UtilColors.mainOrange,
        ),
      ),
      padding: EdgeInsets.all(15.w),
      child: Column(
        children: [
          Text('3 ДНЯ БЕСПЛАТНО', style: UtilTextStyles.trialTitle),
          SizedBox(height: 5.w),
          Text('затем 150 ₽ в месяц', style: UtilTextStyles.trialSubtitle),
        ],
      ),
    );
  }

  Widget advantagesItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(color: UtilColors.mainOrange, shape: BoxShape.circle),
          child: FittedBox(child: UtilIcons(UtilIcons.done)),
        ),
        SizedBox(width: 12.w),
        Text(text, style: UtilTextStyles.advantagesTitle),
      ],
    );
  }

  Widget pricesItem(String id, {bool isRecommended = false}) {
    return Obx(
      () => InkWell(
        onTap: () => controller.selectedItem.value = id,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.w),
            border: Border.all(
              width: 2,
              color: controller.selectedItem.value == id ? UtilColors.mainOrange : Colors.transparent,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          constraints: BoxConstraints(minHeight: 48.w),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(child: Text(controller.getTitle(id), style: UtilTextStyles.priceSubtitle)),
                    if (isRecommended)
                      Container(
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: UtilColors.mainOrange,
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              width: 2,
                              color: isRecommended ? UtilColors.mainOrange : Colors.transparent,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          margin: EdgeInsets.only(left: 10.w),
                          child: Center(child: Text('РЕКОМЕНДУЕМ', style: UtilTextStyles.recommendedTitle))),
                  ],
                ),
              ),
              SizedBox(width: 5.w),
              Text(controller.getPrice(id), style: UtilTextStyles.priceTitle),
            ],
          ),
        ),
      ),
    );
  }
}
