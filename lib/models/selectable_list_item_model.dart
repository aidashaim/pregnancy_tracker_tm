import 'dart:developer';

class SelectableListItemModel {
  late int id;
  late String value;
  late bool isSelected;

  SelectableListItemModel({required this.id, required this.value, this.isSelected = false});

  SelectableListItemModel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'] as int;
      value = json['value'] as String;
      isSelected = json['isSelected'] as bool? ?? false;
    } catch (e) {
      log('selectable_list_item_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {'id': id, 'value': value, 'isSelected': isSelected};
}
