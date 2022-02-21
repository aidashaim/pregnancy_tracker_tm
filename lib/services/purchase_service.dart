import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_controller.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class PurchaseService {
  PurchaseService._internal();

  static final PurchaseService instance = PurchaseService._internal();
  bool isProUser = false;
  bool isOnInit = true;

  late final Set<String> productIds;
  late final String nonConsumable;
  late PaywallController _paywallController;
  final InAppPurchase _connection = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

  bool _isNonConsumable(String id) => id == nonConsumable;

  Future<List<ProductDetails>> products() async {
    return _products.isNotEmpty ? _products : await initStoreInfo();
  }

  Future<void> init() async {
    nonConsumable = Platform.isAndroid ? 'pregnancy_buy' : 'pregnancy_buy_ios';
    productIds = {'pregnancy_sub_1m', 'pregnancy_sub_3m', nonConsumable};
    final Stream<List<PurchaseDetails>> purchaseUpdated = _connection.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      log('purchase listen error ${error.toString()}');
    });
    await _isSubscriptionActive();
  }

  Future<List<ProductDetails>> initStoreInfo() async {
    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(productIds);
    if (productDetailResponse.error == null) {
      _products = productDetailResponse.productDetails;
    }
    return _products;
  }

  Future<void> _isSubscriptionActive() async {
    try {
      await initStoreInfo();
      await _connection.restorePurchases();
    } catch (e) {
      return;
    }
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          setPaywallLoading(true);
          return;
        case PurchaseStatus.error:
        case PurchaseStatus.canceled:
          setPaywallLoading(false);
          return;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (!isOnInit) setPaywallLoading(true);
          final bool isExpired = isExpiredProduct(purchaseDetails);
          if (!isOnInit) setPaywallLoading(false);
          if (isExpired && !isOnInit) {
            showRestoreDialog('Нет активных покупок');
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
            return;
          }
          if (!isOnInit) {
            Get.find<HomeController>().isUserPro.value = true;
            Get.find<SettingsController>().isUserPro.value = true;
          }
          isProUser = true;

          if (!isExpired && !isOnInit && purchaseDetails.status == PurchaseStatus.restored) {
            String title = _products
                .firstWhere((e) => e.id == purchaseDetails.productID)
                .title
                .replaceAll('(com.pregnancytracker.tm (unreviewed))', '')
                .replaceAll('(com.pregnancytracker.tm)', '');

            showRestoreDialog('Восстановлено: \n$title');
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
            return;
          }
          break;
      }
      if (Platform.isAndroid) {
        if (!_isNonConsumable(purchaseDetails.productID)) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _connection.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        try {
          await _connection.completePurchase(purchaseDetails);
        } on InAppPurchaseException catch (error) {
          log('InAppPurchaseException ${error.toString()}');
          _paywallController.isLoading.value = false;
        } catch (error) {
          _paywallController.isLoading.value = false;
        }
        _paywallController.isLoading.value = false;
      }
    }
  }

  bool isExpiredProduct(PurchaseDetails purchaseDetails) {
    DateTime transactionDate = DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate!));
    late DateTime expiredDate;
    switch (purchaseDetails.productID) {
      case 'pregnancy_sub_1m':
        expiredDate = DateTime(
          transactionDate.year,
          transactionDate.month + 1,
          transactionDate.day,
          transactionDate.hour,
          transactionDate.minute,
          transactionDate.second,
          transactionDate.millisecond,
        );
        break;
      case 'pregnancy_sub_3m':
        expiredDate = DateTime(
          transactionDate.year,
          transactionDate.month + 3,
          transactionDate.day,
          transactionDate.hour,
          transactionDate.minute,
          transactionDate.second,
          transactionDate.millisecond,
        );
        break;
      case 'pregnancy_buy':
      case 'pregnancy_buy_ios':
        expiredDate = DateTime(
          transactionDate.year + 100,
          transactionDate.month,
          transactionDate.day,
          transactionDate.hour,
          transactionDate.minute,
          transactionDate.second,
          transactionDate.millisecond,
        );
        break;
    }
    return DateTime.now().isAfter(expiredDate);
  }

  void setPaywallLoading(bool value) {
    _paywallController = Get.find<PaywallController>();
    _paywallController.isLoading.value = value;
  }

  void buyProduct(String id) {
    try {
      final ProductDetails? productDetails = _products.firstWhereOrNull((e) => e.id == id);
      if (productDetails != null) {
        final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
        if (_isNonConsumable(productDetails.id)) {
          InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
        } else {
          InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
        }
      }
    } catch (error) {
      log('buy product error ${error.toString()}');
    }
  }

  Future<void> restorePurchases() async {
    try {
      setPaywallLoading(true);
      await _connection.restorePurchases();
      await Future.delayed(const Duration(seconds: 1));
      setPaywallLoading(false);
      if (!(Get.isDialogOpen ?? false)) {
        showRestoreDialog('Покупки не найдены');
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      }
    } catch (error) {
      log('restore purchases error ${error.toString()}');
    }
  }

  void showRestoreDialog(String text) {
    Get.dialog<bool>(
      Material(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.w))),
              child: Center(
                child: Text(text, style: UtilTextStyles.priceSubtitle, textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
