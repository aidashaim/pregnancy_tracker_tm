import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/selectable_list_item_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class HospitalBagRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<SelectableListItemModel> hospitalBag = [];

  void onInit() {
    Future.wait([getHospitalBagItems()]);
  }

  Future<void> addHospitalBagItem({required String value}) async {
    int lastId = _storage.box.read(UtilStorage.hospitalBagLastId) as int? ?? hospitalBag.length;
    SelectableListItemModel bagItem = SelectableListItemModel(id: lastId + 1, value: value);
    hospitalBag.add(bagItem);
    await _storage.box.write(UtilStorage.hospitalBagLastId, lastId + 1);
    await _storage.box.write(UtilStorage.hospitalBagItems, hospitalBag.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> selectHospitalBagItem({required int id, required bool value}) async {
    hospitalBag.firstWhere((e) => e.id == id).isSelected = value;
    await _storage.box.write(UtilStorage.hospitalBagItems, hospitalBag.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> editHospitalBagItem({required int id, required String value}) async {
    hospitalBag.firstWhere((e) => e.id == id).value = value;
    await _storage.box.write(UtilStorage.hospitalBagItems, hospitalBag.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> deleteHospitalBagItem(SelectableListItemModel hospitalBagItem) async {
    hospitalBag.removeWhere((e) => e.id == hospitalBagItem.id);
    await _storage.box.write(UtilStorage.hospitalBagItems, hospitalBag.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getHospitalBagItems() async {
    final List bagItems = _storage.box.read(UtilStorage.hospitalBagItems) as List? ?? [];
    if (bagItems.isNotEmpty) {
      await Future.forEach(bagItems, (item) {
        hospitalBag.add(SelectableListItemModel.fromJSON(json.decode(item as String)));
      });
    } else {
      int id = 0;
      await Future.forEach(UtilRepo.hospitalBagItems, (item) {
        hospitalBag.add(SelectableListItemModel(id: id, value: (item as String).capitalizeFirst ?? item));
        id++;
      });
    }
    await _storage.box.write(UtilStorage.hospitalBagItems, hospitalBag.map((e) => json.encode(e.toJSON())).toList());
  }
}

HospitalBagRepository hospitalBagRepository = HospitalBagRepository();
