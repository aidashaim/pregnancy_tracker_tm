import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/selectable_list_item_model.dart';
import 'package:pregnancy_tracker_tm/repositories/hospital_bag_repository.dart';
import 'package:pregnancy_tracker_tm/widgets/selectable_list_action_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';

class HospitalBagController extends GetxController with GetSingleTickerProviderStateMixin {
  RxList<SelectableListItemModel> hospitalBagItems = hospitalBagRepository.hospitalBag.obs;
  final TextEditingController valueTextController = TextEditingController();
  SelectableListItemModel? selectedBagItem;

  Future<void> selectAction(SelectableListItemModel bagItem) async {
    bool? action = await Get.dialog<bool>(const SelectableListActionDialog(), barrierDismissible: true);
    if (action == null) {
      return;
    }
    selectedBagItem = bagItem;
    if (action) {
      editBagItem();
    } else {
      deleteBagItem();
    }
  }

  Future<void> selectItem(SelectableListItemModel bagItem) async {
    await hospitalBagRepository.selectHospitalBagItem(id: bagItem.id, value: !bagItem.isSelected);
    updateList();
  }

  Future<void> addBagItem() async {
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
      await hospitalBagRepository.addHospitalBagItem(value: valueTextController.text);
      updateList();
    }
    valueTextController.text = '';
  }

  Future<void> editBagItem() async {
    valueTextController.text = selectedBagItem!.value;
    bool isEdit = await Get.dialog<bool>(
          AppDialog(
            title: 'Редактировать',
            confirmButtonTitle: 'Ок',
            content: AppTextField(withBorder: true, controller: valueTextController),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isEdit && valueTextController.text.isNotEmpty) {
      await hospitalBagRepository.editHospitalBagItem(id: selectedBagItem!.id, value: valueTextController.text);
      updateList();
    }
    valueTextController.text = '';
    selectedBagItem = null;
  }

  Future<void> deleteBagItem() async {
    bool isDelete = await Get.dialog<bool>(
          const AppDialog(title: 'Удалить эту запись?', confirmButtonTitle: 'Ок'),
          barrierDismissible: false,
        ) ??
        false;
    if (isDelete) {
      await hospitalBagRepository.deleteHospitalBagItem(selectedBagItem!);
      updateList();
    }
    selectedBagItem = null;
  }

  void updateList() {
    hospitalBagItems.value = hospitalBagRepository.hospitalBag;
    hospitalBagItems.refresh();
  }
}
