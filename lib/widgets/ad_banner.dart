import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/utils/util_colors.dart';

class AdBanner extends StatefulWidget {
  final bool isHome;
  final double padding;

  const AdBanner({this.isHome = false, this.padding = 0.0, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdBannerState();
}

class AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  final Completer<BannerAd> bannerAdCompleter = Completer<BannerAd>();

  @override
  void initState() {
    super.initState();
    if (!userRepository.currentUser.isPro) {
      _bannerAd = BannerAd(
        adUnitId: // 'ca-app-pub-3940256099942544/6300978111', //InterstitialAd.testAdUnitId,
            Platform.isAndroid ? 'ca-app-pub-7506786058235214/1515702629' : 'ca-app-pub-7506786058235214/6879903460',
        request: const AdRequest(),
        size: widget.isHome
            ? AdSize(width: (Get.size.width - widget.padding).toInt(), height: 228)
            : AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => bannerAdCompleter.complete(ad as BannerAd),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            bannerAdCompleter.completeError('null');
          },
          onAdOpened: (Ad ad) => log('Ad opened.'),
          onAdClosed: (Ad ad) => log('Ad closed.'),
          onAdImpression: (Ad ad) => log('Ad impression.'),
        ),
      );
      _bannerAd?.load();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return !userRepository.currentUser.isPro
        ? Padding(
            padding: EdgeInsets.only(bottom: widget.isHome ? 0 : 20.w),
            child: ClipRRect(
              borderRadius: widget.isHome
                  ? BorderRadius.all(Radius.circular(20.w))
                  //: widget.padding != 0.0
                  //? BorderRadius.only(bottomRight: Radius.circular(0.w), bottomLeft: Radius.circular(20.w))
                  : BorderRadius.zero,
              child: SizedBox(
                width: Get.size.width - widget.padding,
                height: widget.isHome ? 228.w : 250.w,
                child: FutureBuilder<BannerAd>(
                  future: bannerAdCompleter.future,
                  builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
                    Widget child;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        child = CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(UtilColors.redBg),
                        );
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          child = AdWidget(ad: _bannerAd!);
                        } else {
                          child = Icon(Icons.error_outline, color: UtilColors.redBg, size: widget.isHome ? 80.w : 80.w);
                        }
                    }
                    return Center(child: child);
                  },
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
