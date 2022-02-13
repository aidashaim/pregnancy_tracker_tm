import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/repositories/user_repository.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_controller.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';
import 'package:pregnancy_tracker_tm/utils/util_text_styles.dart';

class PurchaseService {
  PurchaseService._internal();

  static final PurchaseService instance = PurchaseService._internal();

  final productIds = {'pregnancy_sub_1m', 'pregnancy_sub_3m', 'pregnancy_buy'};
  late PaywallController _paywallController;
  final InAppPurchase _connection = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

  bool _isNonConsumable(String id) => id == 'pregnancy_buy';

  Future<List<ProductDetails>> products() async {
    return _products.isNotEmpty ? _products : await initStoreInfo();
  }

  void init() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _connection.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      log('purchase listen done');
      _subscription.cancel();
    }, onError: (error) {
      log('purchase listen error ${error.toString()}');
    });
    initStoreInfo();
  }

  Future<List<ProductDetails>> initStoreInfo() async {
    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(productIds);
    if (productDetailResponse.error == null) {
      _products = productDetailResponse.productDetails;
      log('productsss ${_products.length.toString()}');
    }
    for (var product in _products) {
      log('producttt ${product.id} ${product.title} ${product.price}');
    }
    return _products;
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    _paywallController = Get.find<PaywallController>();
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        log('purchase status PENDING');
        _paywallController.isLoading.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          log('purchase status ERROR');
          _paywallController.isLoading.value = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _paywallController.isLoading.value = true;
          log('purchase status PURCHASED or RESTORED');
          log('product ${purchaseDetails.productID}');
          DateTime transactionDate = DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate!));
          log('transaction date $transactionDate');

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

          final StorageProvider _storage = Get.find<StorageProvider>();
          DateTime? dateFromStorage = DateTime.tryParse(_storage.box.read(UtilStorage.dateProExpired) ?? '');
          log('date from storage ${_storage.box.read(UtilStorage.dateProExpired)}');
          log('expired date $expiredDate');

          if ((dateFromStorage != null && dateFromStorage.isAfter(expiredDate)) ||
              DateTime.now().isAfter(expiredDate) ||
              dateFromStorage!.isAtSameMomentAs(expiredDate)) {
            _paywallController.isLoading.value = false;
            showRestoreDialog('Нет активных покупок \nили текущая покупка истекает \nпозднее чем предыдущие');
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
            return;
          }

          log('set new date');
          _storage.box.write(UtilStorage.dateProExpired, expiredDate.toString());
          await userRepository.setProUser(true);
          Get.find<HomeController>().onInit();
          _paywallController.isLoading.value = false;

          if (purchaseDetails.status == PurchaseStatus.restored) {
            showRestoreDialog(
                'Восстановлено: \n${_products.firstWhere((e) => e.id == purchaseDetails.productID).title.replaceAll('(com.pregnancytracker.tm (unreviewed))', '').replaceAll('(com.pregnancytracker.tm)', '')}');
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
          }
        }
        // хз что это
        // if (Platform.isAndroid) {
        //   if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
        //     final InAppPurchaseAndroidPlatformAddition androidAddition =
        //         _connection.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        //     await androidAddition.consumePurchase(purchaseDetails);
        //   }
        // }
        if (purchaseDetails.pendingCompletePurchase) {
          await _connection.completePurchase(purchaseDetails);
          _paywallController.isLoading.value = false;
        }
      }
    }
  }

  void buyProduct(String id) {
    log('buy product $id');
    try {
      final ProductDetails? productDetails = _products.firstWhereOrNull((e) => e.id == id);
      if (productDetails != null) {
        final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
        if (_isNonConsumable(productDetails.id)) {
          InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
        } else {
          InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
        }
      }
    } catch (error) {
      log('buy product error ${error.toString()}');
    }
  }

  Future<void> restorePurchases() async {
    log('restore purchases');
    try {
      await _connection.restorePurchases();
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
