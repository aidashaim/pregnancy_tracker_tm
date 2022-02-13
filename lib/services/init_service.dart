import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracker_tm/providers/api_provider.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/services/api_service.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:pregnancy_tracker_tm/services/interstitial_ad_service.dart';
import 'package:pregnancy_tracker_tm/services/purchase_service.dart';
import 'notification_service.dart';

class InitService {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Intl.defaultLocale = 'ru_RU';
    Intl.systemLocale = 'ru_RU';
    await MobileAds.instance.initialize();
    // MobileAds.instance
    //     .updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['0A40C2261B1F30BC5E7C9A97C3FECBDB']));
    await InterstitialAdService.init();
    await MetricaPlugin.activate(
        GetPlatform.isAndroid ? "7ee309fa-d3b5-4c12-bb89-76108384c818" : "dcbfaf3c-09fd-47dd-aff1-d9522b5a031d");
    FlutterError.onError = (FlutterErrorDetails details) =>
        MetricaPlugin.reportEvent('app_сrash', attributes: {'details': details.toString()});
    NotificationService().init();
    await Get.putAsync(() => StorageProvider().init());
    PurchaseService.instance.init();
    Get.put(ApiProvider());
    Get.put<ApiService>(ApiService());
    MetricaPlugin.reportEvent('load_app');
  }
}
