import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/contraction_counter_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class ContractionCounterRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<ContractionCounterModel> contractions = [];

  void onInit() {
    Future.wait([getContractions()]);
  }

  Future<void> addContraction({required ContractionCounterModel contraction}) async {
    contractions.add(contraction);
    await _storage.box.write(UtilStorage.contractionItems, contractions.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getContractions() async {
    final List contractionItems = _storage.box.read(UtilStorage.contractionItems) as List? ?? [];
    contractions.clear();
    await Future.forEach(contractionItems, (item) {
      contractions.add(ContractionCounterModel.fromJSON(json.decode(item as String)));
    });
    await _storage.box.write(UtilStorage.contractionItems, contractions.map((e) => json.encode(e.toJSON())).toList());
  }
}

ContractionCounterRepository contractionCounterRepository = ContractionCounterRepository();
