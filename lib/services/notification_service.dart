import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_controller.dart';
import 'package:pregnancy_tracker_tm/screens/main/main_controller.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  NotificationService._internal();

  factory NotificationService() => _notificationService;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationDetails platformChannelSpecifics = const NotificationDetails(
    android: AndroidNotificationDetails(
      'id',
      'name',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    ),
    iOS: IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true, badgeNumber: 1),
  );

  Future<void> init() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  Future<void> selectNotification(String? payload) async {
    if (payload != null) {
      if (payload.contains('UtilRoutes') && Get.currentRoute != payload) {
        Get.toNamed(payload);
        return;
      }
      if (payload.contains('date')) {
        if (Get.currentRoute != UtilRoutes.main) {
          Get.toNamed(UtilRoutes.main);
        }
        DateTime date = DateTime.parse(payload.replaceFirst('date ', ''));
        Get.find<MainController>().selectIndex(1);
        Get.find<CalendarController>().onDaySelected(date, date);
        return;
      }
    }
  }

  void onDidReceiveLocalNotification(_, __, ___, String? payload) => selectNotification(payload);

  void show(int id, String title, String text, String payload) {
    flutterLocalNotificationsPlugin.show(id, title, text, platformChannelSpecifics, payload: payload);
  }

  Future<void> showScheduled(int id, String title, String text, DateTime date, String payload) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      text,
      tz.TZDateTime.from(date.toLocal(), tz.local),
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showPeriodically(int id, String title, String text, DateTime date, String payload, bool daily) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      text,
      tz.TZDateTime.local(date.year, date.month, date.day, date.hour, date.minute),
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: daily ? DateTimeComponents.time : DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
