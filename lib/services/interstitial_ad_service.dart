import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdService {
  static final List<InterstitialAd?> _interstitialAd = [null, null, null];
  static final List<int> _interstitialLoadAttempts = [0, 0, 0];
  static const int maxFailedLoadAttempts = 3;

  static Future<void> init() async {
    _createInterstitialAd(0);
    _createInterstitialAd(1);
    _createInterstitialAd(2);
  }

  static String interstitialAdUnitId(int index) {
    if (Platform.isAndroid) {
      return _androidAds[index];
    } else if (Platform.isIOS) {
      return _iosAds[index];
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static void _createInterstitialAd(int index) {
    InterstitialAd.load(
      adUnitId: //InterstitialAd.testAdUnitId,
          interstitialAdUnitId(index),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd[index] = ad;
          _interstitialLoadAttempts[index] = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts[index] += 1;
          _interstitialAd[index] = null;
          if (_interstitialLoadAttempts[index] <= maxFailedLoadAttempts) {
            _createInterstitialAd(index);
          }
        },
      ),
    );
  }

  static void showInterstitialAd(int index) {
    if (_interstitialAd[index] != null) {
      _interstitialAd[index]!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd(index);
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd(index);
        },
      );
      _interstitialAd[index]!.show();
    }
  }

  static final List<String> _iosAds = [
    'ca-app-pub-7506786058235214/8621851231',
    'ca-app-pub-7506786058235214/3097938105',
    'ca-app-pub-7506786058235214/1244433406',
  ];

  static final List<String> _androidAds = [
    'ca-app-pub-7506786058235214/3108179419',
    'ca-app-pub-7506786058235214/3156087352',
    'ca-app-pub-7506786058235214/8216842345',
  ];
}
