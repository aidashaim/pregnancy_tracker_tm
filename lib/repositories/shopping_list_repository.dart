import 'dart:convert';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/selectable_list_item_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_repo.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class ShoppingListRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<SelectableListItemModel> cribList = [];
  List<SelectableListItemModel> strollerList = [];
  List<SelectableListItemModel> bathingList = [];
  List<SelectableListItemModel> feedingList = [];
  List<SelectableListItemModel> clothesList = [];
  List<SelectableListItemModel> diapersList = [];
  List<SelectableListItemModel> aidList = [];

  void onInit() {
    Future.wait([
      getListItems(0),
      getListItems(1),
      getListItems(2),
      getListItems(3),
      getListItems(4),
      getListItems(5),
      getListItems(6),
    ]);
  }

  Future<void> addListItem({required String value, required int index}) async {
    String listName = getListName(index);
    int lastId = _storage.box.read(UtilStorage.shoppingListLastId(listName)) as int? ?? getList(index).length;
    SelectableListItemModel bagItem = SelectableListItemModel(id: lastId + 1, value: value);
    getList(index).add(bagItem);
    await _storage.box.write(UtilStorage.shoppingListLastId(listName), lastId + 1);
    await _storage.box
        .write(UtilStorage.shoppingListItems(listName), getList(index).map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> selectListItem({required SelectableListItemModel item, required bool value, required int index}) async {
    getList(index).firstWhere((e) => e.id == item.id).isSelected = value;
    await _storage.box.write(
        UtilStorage.shoppingListItems(getListName(index)), getList(index).map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> editListItem({required int id, required String value, required int index}) async {
    getList(index).firstWhere((e) => e.id == id).value = value;
    await _storage.box.write(
        UtilStorage.shoppingListItems(getListName(index)), getList(index).map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> deleteListItem({required SelectableListItemModel listItem, required int index}) async {
    getList(index).removeWhere((e) => e.id == listItem.id);
    await _storage.box.write(
        UtilStorage.shoppingListItems(getListName(index)), getList(index).map((e) => json.encode(e.toJSON())).toList());
  }

  Future<void> getListItems(int index) async {
    final String _name = UtilStorage.shoppingListItems(getListName(index));
    final List listItems = _storage.box.read(_name) as List? ?? [];
    if (listItems.isNotEmpty) {
      await Future.forEach(listItems, (item) {
        getList(index).add(SelectableListItemModel.fromJSON(json.decode(item as String)));
      });
    } else {
      int id = 0;
      await Future.forEach(getItemsList(index), (item) {
        getList(index).add(SelectableListItemModel(id: id, value: (item as String).capitalizeFirst ?? item));
        id++;
      });
    }
    await _storage.box.write(_name, getList(index).map((e) => json.encode(e.toJSON())).toList());
  }

  String getListName(int index) {
    switch (index) {
      case 0:
        return 'cribList';
      case 1:
        return 'strollerList';
      case 2:
        return 'bathingList';
      case 3:
        return 'feedingList';
      case 4:
        return 'clothesList';
      case 5:
        return 'diapersList';
      default:
        return 'aidList';
    }
  }

  List<SelectableListItemModel> getList(int index) {
    switch (index) {
      case 0:
        return cribList;
      case 1:
        return strollerList;
      case 2:
        return bathingList;
      case 3:
        return feedingList;
      case 4:
        return clothesList;
      case 5:
        return diapersList;
      default:
        return aidList;
    }
  }

  List<String> getItemsList(int index) {
    switch (index) {
      case 0:
        return UtilRepo.cribListItems;
      case 1:
        return UtilRepo.strollerListItems;
      case 2:
        return UtilRepo.bathingListItems;
      case 3:
        return UtilRepo.feedingListItems;
      case 4:
        return UtilRepo.clothesListItems;
      case 5:
        return UtilRepo.diapersListItems;
      default:
        return UtilRepo.aidListItems;
    }
  }
}

ShoppingListRepository shoppingListRepository = ShoppingListRepository();
