import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class WeeklyAdvicesRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<bool> advicesShown = [];

  void onInit() {
    Future.wait([getAdvicesShown()]);
  }

  Future<void> addShown({required int adviceIndex}) async {
    final List advicesShownItems = _storage.box.read(UtilStorage.weeklyAdvicesShown) as List? ?? [];
    advicesShown[adviceIndex] = true;
    advicesShownItems.add(adviceIndex);
    await _storage.box.write(UtilStorage.weeklyAdvicesShown, advicesShownItems.map((e) => json.encode(e)).toList());
  }

  Future<void> getAdvicesShown() async {
    final List advicesShownItems = _storage.box.read(UtilStorage.weeklyAdvicesShown) as List? ?? [];
    advicesShown = [false, false, false];
    await Future.forEach(advicesShownItems, (item) {
      advicesShown[int.parse(item as String)] = true;
    });
  }
}

WeeklyAdvicesRepository weeklyAdvicesRepository = WeeklyAdvicesRepository();
