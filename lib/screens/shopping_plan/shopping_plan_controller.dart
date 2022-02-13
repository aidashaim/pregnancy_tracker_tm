import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/selectable_list_item_model.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/selectable_list_action_dialog.dart';
import 'package:pregnancy_tracker_tm/repositories/shopping_list_repository.dart';

class ShoppingPlanController extends GetxController with GetSingleTickerProviderStateMixin {
  final TextEditingController valueTextController = TextEditingController();
  late TabController tabController;

  RxList<List<SelectableListItemModel>> itemLists = [
    shoppingListRepository.cribList,
    shoppingListRepository.strollerList,
    shoppingListRepository.bathingList,
    shoppingListRepository.feedingList,
    shoppingListRepository.clothesList,
    shoppingListRepository.diapersList,
    shoppingListRepository.aidList,
  ].obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 7);
    super.onInit();
  }

  SelectableListItemModel? selectedBagItem;

  Future<void> selectAction(SelectableListItemModel bagItem) async {
    bool? action = await Get.dialog<bool>(const SelectableListActionDialog(), barrierDismissible: true);
    if (action == null) {
      return;
    }
    selectedBagItem = bagItem;
    if (action) {
      editListItem();
    } else {
      deleteListItem();
    }
  }

  Future<void> selectItem(SelectableListItemModel bagItem) async {
    await shoppingListRepository.selectListItem(item: bagItem, value: !bagItem.isSelected, index: tabController.index);
    updateLists();
  }

  Future<void> addListItem() async {
    bool isAdd = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить',
            confirmButtonTitle: 'Ок',
            content: AppTextField(hint: 'Название', withBorder: true, controller: valueTextController, maxLines: 1),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isAdd && valueTextController.text.isNotEmpty) {
      await shoppingListRepository.addListItem(value: valueTextController.text, index: tabController.index);
      updateLists();
    }
    valueTextController.text = '';
  }

  Future<void> editListItem() async {
    valueTextController.text = selectedBagItem!.value;
    bool isEdit = await Get.dialog<bool>(
          AppDialog(
            title: 'Редактировать',
            confirmButtonTitle: 'Ок',
            content: AppTextField(withBorder: true, controller: valueTextController, maxLines: 1),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isEdit && valueTextController.text.isNotEmpty) {
      await shoppingListRepository.editListItem(
          id: selectedBagItem!.id, value: valueTextController.text, index: tabController.index);
      updateLists();
    }
    valueTextController.text = '';
    selectedBagItem = null;
  }

  Future<void> deleteListItem() async {
    bool isDelete = await Get.dialog<bool>(
          const AppDialog(title: 'Удалить эту запись?', confirmButtonTitle: 'Ок'),
          barrierDismissible: false,
        ) ??
        false;
    if (isDelete) {
      await shoppingListRepository.deleteListItem(listItem: selectedBagItem!, index: tabController.index);
      updateLists();
    }
    selectedBagItem = null;
  }

  void updateLists() {
    itemLists.value = [
      shoppingListRepository.cribList,
      shoppingListRepository.strollerList,
      shoppingListRepository.bathingList,
      shoppingListRepository.feedingList,
      shoppingListRepository.clothesList,
      shoppingListRepository.diapersList,
      shoppingListRepository.aidList,
    ];
    itemLists.refresh();
  }
}
