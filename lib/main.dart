import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/services/init_service.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

void main() async {
  await InitService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Get.width, Get.height),
      builder: () => GetMaterialApp(
        title: 'Pregnancy Tracker',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData.light().copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        initialRoute: UtilRoutes.splash,
        getPages: UtilRoutes.pages,
        defaultTransition: Transition.fade,
        locale: const Locale('ru', 'RU'),
        fallbackLocale: const Locale('ru', 'RU'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', 'RU')],
      ),
    );
  }
}
