import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

class UtilFormatters {
  UtilFormatters._();

  static String gestationalAge({
    required int term,
    bool withDays = true,
    bool withWeeks = true,
    bool twoLines = false,
    bool short = false,
  }) {
    String age = '';
    int weeks = term ~/ 7;
    int days = term % 7;
    if (withWeeks && weeks != 0) {
      int remainder = weeks % 10;
      if (short) {
        age = weeks.toString() + ' нед. ';
      } else {
        if (remainder == 1) {
          age = weeks.toString() + ' неделю ';
        }
        if (remainder > 1 && remainder < 5) {
          age = weeks.toString() + ' недели ';
        }
        if ((remainder >= 5 && remainder < 10) || remainder == 0) {
          age = weeks.toString() + ' недель ';
        }
      }
    }

    if (withDays && days != 0) {
      int remainder = days % 10;
      if (short) {
        age += days.toString() + ' дн. ';
      } else {
        if (twoLines && age.isNotEmpty) age += '\n';
        if (remainder == 1) {
          age += days.toString() + ' день';
        }
        if (remainder > 1 && remainder < 5) {
          age += days.toString() + ' дня';
        }
        if ((remainder >= 5 && remainder < 10) || remainder == 0) {
          age += days.toString() + ' дней';
        }
      }
    }
    return age;
  }

  static String deleteHtmlTags(String string) => parse(string).documentElement!.text;

  /// Дата
  static String date(DateTime dateTime) => DateFormat('dd.MM.yyyy', 'ru_RU').format(dateTime);

  /// День и месяц
  static String dayMonth(DateTime dateTime) => DateFormat('d MMMM', 'ru_RU').format(dateTime);

  /// Дата с прописью
  static String dateWithMonth(DateTime dateTime) => DateFormat('d MMMM yyyy', 'ru_RU').format(dateTime);

  /// Дата и время
  static String dateWithTime(DateTime dateTime) => DateFormat('dd.MM.yyyy HH:mm', 'ru_RU').format(dateTime);

  /// Дата и сокращенный месяц
  static String shortDateMonth(DateTime? dateTime) =>
      dateTime != null ? DateFormat('dd MMMM', 'ru_RU').format(dateTime).substring(0, 6) + '.' : '';

  /// Дата, сокращенный месяц и время
  static String shortDateMonthWithTime(DateTime? dateTime) =>
      dateTime != null ? shortDateMonth(dateTime) + ' ' + DateFormat('HH:mm', 'ru_RU').format(dateTime) : '';

  /// Время
  static String time(TimeOfDay? time) => time != null
      ? '${time.hour > 9 ? time.hour : '0${time.hour}'}:'
          '${time.minute > 9 ? time.minute : '0${time.minute}'}'
      : '';
}
