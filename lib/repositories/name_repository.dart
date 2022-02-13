import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/name_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class NameRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<NameModel> allNames = [];
  List<NameModel> boyNames = [];
  List<NameModel> girlNames = [];
  List<NameModel> savedNames = [];

  void onInit() {
    allNames.addAll(UtilRepo.names);
    Future.wait([getCustomNames()]);
    Future.wait([getSavedNames()]);

    for (final name in allNames) {
      name.sex ? girlNames.add(name) : boyNames.add(name);
      if (name.isSaved) {
        savedNames.add(name);
      }
    }
    girlNames.sort((a, b) => a.name.compareTo(b.name));
    boyNames.sort((a, b) => a.name.compareTo(b.name));
    savedNames.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> addCustomName({required String name, required bool sex, String? meaning}) async {
    final List customNames = _storage.box.read(UtilStorage.customNames) as List? ?? [];
    int lastCustomId = _storage.box.read(UtilStorage.customNameLastId) as int? ?? 243;
    NameModel customName = NameModel(id: lastCustomId + 1, name: name, meaning: meaning, sex: sex);
    customNames.add(json.encode(customName.toJSON()));
    customName.sex ? girlNames.add(customName) : boyNames.add(customName);
    girlNames.sort((a, b) => a.name.compareTo(b.name));
    boyNames.sort((a, b) => a.name.compareTo(b.name));
    await _storage.box.write(UtilStorage.customNames, customNames);
    await _storage.box.write(UtilStorage.customNameLastId, lastCustomId + 1);
  }

  Future<void> saveName(NameModel name) async {
    final List savedIds = _storage.box.read(UtilStorage.savedNamesId) as List? ?? [];
    if (name.isSaved) {
      savedIds.removeWhere((e) => e == name.id.toString());
      savedNames.removeWhere((e) => e.id.toString() == name.id.toString());
    } else {
      savedIds.add(name.id.toString());
      savedNames.add(name);
      savedNames.sort((a, b) => a.name.compareTo(b.name));
    }
    if (name.sex) {
      girlNames.firstWhere((element) => element.id == name.id).isSaved = !name.isSaved;
    } else {
      boyNames.firstWhere((element) => element.id == name.id).isSaved = !name.isSaved;
    }
    await _storage.box.write(UtilStorage.savedNamesId, savedIds);
  }

  Future<void> getCustomNames() async {
    final List customNames = _storage.box.read(UtilStorage.customNames) as List? ?? [];
    await Future.forEach(customNames, (name) {
      allNames.add(NameModel.fromJSON(json.decode(name as String)));
    });
  }

  Future<void> getSavedNames() async {
    final List savedIds = _storage.box.read(UtilStorage.savedNamesId) as List? ?? [];
    await Future.forEach(savedIds, (nameId) {
      allNames.firstWhere((name) => name.id.toString() == nameId).isSaved = true;
    });
  }
}

NameRepository nameRepository = NameRepository();
