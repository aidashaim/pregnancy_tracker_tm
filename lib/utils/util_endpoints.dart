class UtilEndpoints {
  UtilEndpoints._();

  static canOrCant(String type) => 'can-or-cant/$type/ru';
  static dailyAdvice(int day) => 'daily-advice/$day/ru';
  static weeklyAdviceBaby(int week) => 'weekly-advice-baby/$week/ru';
  static weeklyAdviceMom(int week) => 'weekly-advice-mom/$week/ru';
  static weeklyAdviceGeneral(int week) => 'weekly-general/$week/ru';
}
