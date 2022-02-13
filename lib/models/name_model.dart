import 'dart:developer';

class NameModel {
  late int id;
  late String name;
  late bool sex;
  String? meaning;
  late bool isSaved;

  NameModel({required this.id, required this.name, required this.sex, this.meaning, this.isSaved = false});

  NameModel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'] as int;
      name = json['name'] as String;
      sex = json['sex'] as bool;
      meaning = json['meaning'] as String?;
      isSaved = json['isSaved'] as bool? ?? false;
    } catch (e) {
      log('name_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'sex': sex,
        'meaning': meaning,
        'isSaved': isSaved,
      };
}
