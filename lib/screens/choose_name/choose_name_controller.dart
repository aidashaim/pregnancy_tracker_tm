import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/name_model.dart';
import 'package:pregnancy_tracker_tm/repositories/name_repository.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';

class ChooseNameController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxInt selectedTab = 0.obs;
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController meaningTextController = TextEditingController();
  late TabController tabController;

  RxList<List<NameModel>> nameLists =
      [nameRepository.girlNames, nameRepository.boyNames, nameRepository.savedNames].obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(() => selectedTab.value = tabController.index);
    super.onInit();
  }

  Future<void> addName() async {
    bool name = await Get.dialog<bool>(
          AppDialog(
            title: 'Добавить имя',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(hint: 'Имя', withBorder: true, controller: nameTextController, maxLines: 1),
                SizedBox(height: 10.w),
                AppTextField(hint: 'Значение', withBorder: true, controller: meaningTextController, maxLines: 2),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (name && nameTextController.text.isNotEmpty) {
      await nameRepository.addCustomName(
        name: nameTextController.text,
        meaning: meaningTextController.text,
        sex: tabController.index == 0,
      );
      updateLists();
    }
  }

  Future<void> saveNameTap(NameModel name) async {
    await nameRepository.saveName(name);
    updateLists();
  }

  void updateLists() {
    nameLists.value = [nameRepository.girlNames, nameRepository.boyNames, nameRepository.savedNames];
    nameLists.refresh();
  }
}
