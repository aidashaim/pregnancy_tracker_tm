import 'dart:developer';
import 'package:pregnancy_tracker_tm/utils/util_formatters.dart';

class WeeklyAdviceModel {
  late final String img;
  late final String title;
  late final String text;

  WeeklyAdviceModel({required this.img, required this.title, required this.text});

  WeeklyAdviceModel.fromJSON(Map<String, dynamic> json) {
    try {
      img = json['img'] is bool ? '' : json['img'] as String? ?? '';
      title = UtilFormatters.deleteHtmlTags(json['title'] as String? ?? '');
      text = json['text'] as String? ?? '';
    } catch (e) {
      log('weekly_advice_model error: $e');
    }
  }

  Map<String, dynamic> toJSON() => {
        'img': img,
        'title': title,
        'text': text,
      };
}
