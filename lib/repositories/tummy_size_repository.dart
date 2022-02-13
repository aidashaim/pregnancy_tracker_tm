import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/tummy_size_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class TummySizeRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<TummySizeModel> sizes = [];
  bool hasSizeToday = false;

  void onInit() {
    Future.wait([getTummySizes()]);
  }

  Future<void> addTummySize({required TummySizeModel size}) async {
    TummySizeModel? _size;
    if (sizes.isNotEmpty) {
      _size = sizes.firstWhereOrNull((e) => e.days == size.days);
      if (_size != null) {
        int index = sizes.indexOf(_size);
        sizes[index] = size;
        await _storage.box.write(UtilStorage.tummySizeItems, sizes.map((e) => json.encode(e.toJSON())).toList());
        return;
      }
    }

    if (UtilFormatters.date(DateTime.now()) == size.date) {
      hasSizeToday = true;
    }

    sizes.add(size);
    sizes.sort((a, b) => a.days.compareTo(b.days));
    await _storage.box.write(UtilStorage.tummySizeItems, sizes.map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getTummySizes() async {
    final List sizeItems = _storage.box.read(UtilStorage.tummySizeItems) as List? ?? [];
    await Future.forEach(sizeItems, (item) {
      sizes.add(TummySizeModel.fromJSON(json.decode(item as String)));
      if (UtilFormatters.date(DateTime.now()) == sizes.last.date) {
        hasSizeToday = true;
      }
    });
    await _storage.box.write(UtilStorage.tummySizeItems, sizes.map((e) => json.encode(e.toJSON())).toList());
  }

  void saveToStorage() => _storage.box.write(
        UtilStorage.tummySizeItems,
        sizes.map((e) => json.encode(e.toJSON())).toList(),
      );
}

TummySizeRepository tummySizeRepository = TummySizeRepository();
