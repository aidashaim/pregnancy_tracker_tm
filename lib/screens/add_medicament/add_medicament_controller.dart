import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/medicament_model.dart';
import 'package:pregnancy_tracker_tm/widgets/app_dialog.dart';
import 'package:pregnancy_tracker_tm/widgets/app_text_field.dart';
import 'package:pregnancy_tracker_tm/widgets/pickers.dart';

class AddMedicamentController extends GetxController {
  final RxString name = 'Название'.obs;
  final RxString type = 'Таблетка'.obs;
  final RxString period = 'Каждый день'.obs;
  final RxString diet = 'Не зависит от еды'.obs;
  final Rx<DateTime> dateStart = DateTime.now().obs;
  final RxBool notification = false.obs;
  final RxBool buttonActive = true.obs;
  final RxList<TimeOfDay> selectedTimes = <TimeOfDay>[const TimeOfDay(hour: 8, minute: 0)].obs;
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController dosageTextController = TextEditingController();
  final TextEditingController countTextController = TextEditingController();
  final TextEditingController durationTextController = TextEditingController();
  MedicamentModel? initialMedicament;

  final List<String> typeItems = [
    'Таблетка',
    'Капсула',
    'Капли',
    'Уколы',
    'Микстура',
    'Мазь',
    'Гель',
    'Крем',
    'Спрей',
    'Аэрозоль',
  ];

  final List<String> dietItems = ['Не зависит от еды', 'Зависит от еды'];

  final List<String> periodItems = ['Каждый день', 'Через день'];

  @override
  void onInit() {
    dateStart.value = Get.arguments['date'];
    initialMedicament = Get.arguments['event'];
    if (initialMedicament != null) {
      name.value = initialMedicament!.name;
      type.value = initialMedicament!.type;
      period.value = initialMedicament!.period;
      diet.value = initialMedicament!.diet;
      notification.value = initialMedicament!.needNotification;
      dateStart.value = initialMedicament!.dateStart;
      selectedTimes.value = initialMedicament!.times;
      dosageTextController.text = initialMedicament!.dosage;
      durationTextController.text = initialMedicament!.duration.toString();
      countTextController.text = initialMedicament!.count.toString();
    }

    countTextController.addListener(updateTimes);
    nameTextController.addListener(buttonIsActive);
    durationTextController.addListener(buttonIsActive);
    countTextController.addListener(buttonIsActive);
    dosageTextController.addListener(buttonIsActive);
    super.onInit();
  }

  void buttonIsActive() {
    buttonActive.value = !(name.value.isEmpty ||
        dosageTextController.text.isEmpty ||
        countTextController.text.isEmpty ||
        durationTextController.text.isEmpty);
  }

  void updateTimes() {
    selectedTimes.clear();
    int _count = int.tryParse(countTextController.text) ?? 1;
    int offset = 12 * 60 ~/ _count;
    for (int i = 0; i < _count; i++) {
      selectedTimes.add(TimeOfDay(hour: 8 + (offset * i) ~/ 60, minute: (offset * i) % 60));
    }
  }

  Future<void> setName() async {
    bool isAdd = await Get.dialog<bool>(
          AppDialog(
            title: 'Изменить название',
            confirmButtonTitle: 'Ок',
            content: Column(
              children: [
                AppTextField(
                  hint: 'Название',
                  withBorder: true,
                  controller: nameTextController,
                  type: TextInputType.text,
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        ) ??
        false;
    if (isAdd && nameTextController.text.isNotEmpty) {
      name.value = nameTextController.text;
    }
  }

  Future<void> selectTime(TimeOfDay time) async {
    final TimeOfDay? pickedTime = await showCustomTimePicker();
    if (pickedTime != null) {
      int index = selectedTimes.indexOf(time);
      selectedTimes[index] = pickedTime;
    }
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showCustomDatePicker();
    if (pickedDate != null) {
      dateStart.value = pickedDate;
    }
  }

  void add() {
    int _duration = int.parse(durationTextController.text);
    List<DateTime> dates = [];
    for (int i = 0; i < _duration; i++) {
      if (period.value != 'Каждый день') i++;
      dates.add(dateStart.value.add(Duration(days: i)));
    }
    MedicamentModel medicament = MedicamentModel(
      name: name.value,
      type: type.value,
      dosage: dosageTextController.text,
      count: int.parse(countTextController.text),
      period: period.value,
      diet: diet.value,
      duration: _duration,
      dateStart: dateStart.value,
      times: selectedTimes,
      needNotification: notification.value,
      dates: dates,
    );
    Get.back(result: medicament);
  }
}
