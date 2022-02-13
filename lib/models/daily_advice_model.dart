import 'dart:developer';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';

class DailyAdviceModel {
  late final String img;
  late final String title;
  late final String text;
  late bool isSaved;
  int? day;

  DailyAdviceModel({required this.img, required this.title, required this.text, this.isSaved = false, this.day});

  DailyAdviceModel.fromJSON(Map<String, dynamic> json) {
    try {
      img = json['img'] is bool ? '' : json['img'] as String? ?? '';
      title = UtilFormatters.deleteHtmlTags(json['title'] as String? ?? '');
      text = json['text'] as String? ?? '';
      isSaved = false;
    } catch (e) {
      log('daily_advice_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'img': img,
        'title': title,
        'text': text,
      };
}
