import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/my_weight_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class MyWeightRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<MyWeightModel> weights = [];
  bool hasWeightToday = false;

  void onInit() {
    Future.wait([getMyWeights()]);
  }

  Future<void> addMyWeights({required MyWeightModel weight}) async {
    MyWeightModel? _weight;
    if (weights.isNotEmpty) {
      _weight = weights.firstWhereOrNull((e) => e.days == weight.days);
      if (_weight != null) {
        int index = weights.indexOf(_weight);
        weights[index] = weight;
        await _storage.box.write(UtilStorage.myWeightItems, weights.map((e) => json.encode(e.toJSON())).toList());
        return;
      }
    }

    if (UtilFormatters.date(DateTime.now()) == weight.date) {
      hasWeightToday = true;
    }

    weights.add(weight);
    weights.sort((a, b) => a.days.compareTo(b.days));
    await _storage.box.write(UtilStorage.myWeightItems, weights.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getMyWeights() async {
    final List weightItems = _storage.box.read(UtilStorage.myWeightItems) as List? ?? [];
    await Future.forEach(weightItems, (item) {
      weights.add(MyWeightModel.fromJSON(json.decode(item as String)));

      if (UtilFormatters.date(DateTime.now()) == weights.last.date) {
        hasWeightToday = true;
      }
    });
    await _storage.box.write(UtilStorage.myWeightItems, weights.map((e) => json.encode(e.toJSON())).toList());
  }

  void saveToStorage() => _storage.box.write(
        UtilStorage.myWeightItems,
        weights.map((e) => json.encode(e.toJSON())).toList(),
      );
}

MyWeightRepository myWeightRepository = MyWeightRepository();
