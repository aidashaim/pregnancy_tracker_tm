import 'dart:developer';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';

class CanOrCantModel {
  late final String img;
  late final String title;
  late final String text;
  late final String status;
  late final String type;
  late bool isSaved;

  CanOrCantModel({
    required this.img,
    required this.title,
    required this.text,
    required this.status,
    required this.type,
    this.isSaved = false,
  });

  CanOrCantModel.fromJSON(Map<String, dynamic> json) {
    try {
      img = json['img'] is String ? json['img'] : '';
      title = UtilFormatters.deleteHtmlTags(json['title'] as String? ?? '');
      text = json['text'] as String? ?? '';
      status = json['status'] as String;
      isSaved = false;
    } catch (e) {
      log('can_or_cant_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'img': img,
        'title': title,
        'ext': text,
        'status': status,
      };
}
