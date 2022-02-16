import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pregnancy_tracker_tm/services/purchase_service.dart';

class PaywallController extends GetxController {
  final RxBool isTrial = true.obs;
  final RxBool isAndroid = false.obs;
  final RxBool isLoading = false.obs;
  final RxString selectedItem = ''.obs;
  List<ProductDetails> products = [];
  List<String> ids = [];

  @override
  onInit() {
    isAndroid.value = Platform.isAndroid;
    getItems();
    super.onInit();
  }

  Future<void> getItems() async {
    ids = PurchaseService.instance.productIds.map((e) => e).toList();
    products = await PurchaseService.instance.products();
    if (ids.isNotEmpty) {
      selectedItem.value = ids[1];
    }
  }

  String getPrice(String id) {
    return products.firstWhereOrNull((e) => e.id == id)?.price ?? '';
  }

  String getTitle(String id) {
    return products
            .firstWhereOrNull((e) => e.id == id)
            ?.title
            .replaceAll('(com.pregnancytracker.tm (unreviewed))', '')
            .replaceAll('(com.pregnancytracker.tm)', '') ??
        '';
  }

  void buyProduct() => PurchaseService.instance.buyProduct(selectedItem.value);

  Future<void> restorePurchase() async {
    await PurchaseService.instance.restorePurchases();
  }
}
