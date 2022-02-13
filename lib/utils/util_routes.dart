import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/screens/add_medicament/add_medicament_binding.dart';
import 'package:pregnancy_tracker_tm/screens/add_medicament/add_medicament_screen.dart';
import 'package:pregnancy_tracker_tm/screens/add_movement/add_movement_binding.dart';
import 'package:pregnancy_tracker_tm/screens/add_movement/add_movement_screen.dart';
import 'package:pregnancy_tracker_tm/screens/add_note_and_doctor/add_note_and_doctor_screen.dart';
import 'package:pregnancy_tracker_tm/screens/add_note_and_doctor/add_note_and_doctor_binding.dart';
import 'package:pregnancy_tracker_tm/screens/article_view/article_view_binding.dart';
import 'package:pregnancy_tracker_tm/screens/article_view/article_view_screen.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_binding.dart';
import 'package:pregnancy_tracker_tm/screens/calendar/calendar_screen.dart';
import 'package:pregnancy_tracker_tm/screens/can_or_cant/can_or_cant_binding.dart';
import 'package:pregnancy_tracker_tm/screens/can_or_cant/can_or_cant_screen.dart';
import 'package:pregnancy_tracker_tm/screens/choose_name/choose_name_binding.dart';
import 'package:pregnancy_tracker_tm/screens/choose_name/choose_name_screen.dart';
import 'package:pregnancy_tracker_tm/screens/contraction_counter/contraction_counter_binding.dart';
import 'package:pregnancy_tracker_tm/screens/contraction_counter/contraction_counter_screen.dart';
import 'package:pregnancy_tracker_tm/screens/daily_advice_view/daily_advice_view_binding.dart';
import 'package:pregnancy_tracker_tm/screens/daily_advice_view/daily_advice_view_screen.dart';
import 'package:pregnancy_tracker_tm/screens/home/home_binding.dart';
import 'package:pregnancy_tracker_tm/screens/hospital_bag/hospital_bag_binding.dart';
import 'package:pregnancy_tracker_tm/screens/hospital_bag/hospital_bag_screen.dart';
import 'package:pregnancy_tracker_tm/screens/i_gave_birth/i_gabe_birth_binding.dart';
import 'package:pregnancy_tracker_tm/screens/i_gave_birth/i_gabe_birth_screen.dart';
import 'package:pregnancy_tracker_tm/screens/login/login_binding.dart';
import 'package:pregnancy_tracker_tm/screens/login/login_screen.dart';
import 'package:pregnancy_tracker_tm/screens/login_second/login_second_binding.dart';
import 'package:pregnancy_tracker_tm/screens/login_second/login_second_screen.dart';
import 'package:pregnancy_tracker_tm/screens/main/main_binding.dart';
import 'package:pregnancy_tracker_tm/screens/main/main_screen.dart';
import 'package:pregnancy_tracker_tm/screens/masters/masters_binding.dart';
import 'package:pregnancy_tracker_tm/screens/masters/masters_screen.dart';
import 'package:pregnancy_tracker_tm/screens/movement_counter/movement_counter_binding.dart';
import 'package:pregnancy_tracker_tm/screens/movement_counter/movement_counter_screen.dart';
import 'package:pregnancy_tracker_tm/screens/my_weight/my_weight_binding.dart';
import 'package:pregnancy_tracker_tm/screens/my_weight/my_weight_screen.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_binding.dart';
import 'package:pregnancy_tracker_tm/screens/paywall/paywall_screen.dart';
import 'package:pregnancy_tracker_tm/screens/saved_articles/saved_articles_binding.dart';
import 'package:pregnancy_tracker_tm/screens/saved_articles/saved_articles_screen.dart';
import 'package:pregnancy_tracker_tm/screens/select_time/select_time_binding.dart';
import 'package:pregnancy_tracker_tm/screens/select_time/select_time_screen.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_binding.dart';
import 'package:pregnancy_tracker_tm/screens/settings/settings_screen.dart';
import 'package:pregnancy_tracker_tm/screens/shopping_plan/shopping_plan_binding.dart';
import 'package:pregnancy_tracker_tm/screens/shopping_plan/shopping_plan_screen.dart';
import 'package:pregnancy_tracker_tm/screens/splash/splash_binding.dart';
import 'package:pregnancy_tracker_tm/screens/splash/splash_screen.dart';
import 'package:pregnancy_tracker_tm/screens/tummy_size/tummy_size_binding.dart';
import 'package:pregnancy_tracker_tm/screens/tummy_size/tummy_size_screen.dart';
import 'package:pregnancy_tracker_tm/screens/weekly_advice_view/weekly_advice_view_binding.dart';
import 'package:pregnancy_tracker_tm/screens/weekly_advice_view/weekly_advice_view_screen.dart';
import 'package:pregnancy_tracker_tm/screens/yes_no_attention/yes_no_attention_binding.dart';
import 'package:pregnancy_tracker_tm/screens/yes_no_attention/yes_no_attention_screen.dart';

class UtilRoutes {
  UtilRoutes._();

  static const addDoctor = '/add-doctor';
  static const addMedicament = '/add-medicament';
  static const addMovement = '/add-movement';
  static const addNote = '/add-note';
  static const articleView = '/article-view';
  static const calendar = '/calendar';
  static const canOrCant = '/can-or-cant';
  static const chooseName = '/choose-name';
  static const contractionCounter = '/contraction-counter';
  static const dailyAdviceView = '/daily_advice_view';
  static const hospitalBag = '/hospital-bag';
  static const iGaveBirth = '/i_gave_birth';
  static const login = '/login';
  static const loginSecond = '/login-second';
  static const main = '/main';
  static const masters = '/masters';
  static const movementCounter = '/movement-counter';
  static const myWeight = '/my-weight';
  static const paywall = '/paywall';
  static const savedArticles = '/saved-articles';
  static const selectTime = '/select-time';
  static const settings = '/settings';
  static const shoppingList = '/shopping-list';
  static const splash = '/splash';
  static const tummySize = '/tummy-size';
  static const yesNoAttention = '/yes-no-attention';
  static const weeklyAdviceView = '/weekly-advice-view';

  static Widget addDoctorScreen = const AddNoteAndDoctorScreen(isNote: false);
  static Widget addMedicamentScreen = const AddMedicamentScreen();
  static Widget addMovementScreen = const AddMovementScreen();
  static Widget addNoteScreen = const AddNoteAndDoctorScreen(isNote: true);
  static Widget articleViewScreen = const ArticleViewScreen();
  static Widget calendarScreen = const CalendarScreen();
  static Widget canOrCantScreen = const CanOrCantScreen();
  static Widget chooseNameScreen = const ChooseNameScreen();
  static Widget contractionCounterScreen = const ContractionCounterScreen();
  static Widget dailyAdviceViewScreen = const DailyAdviceViewScreen();
  static Widget hospitalBagScreen = const HospitalBagScreen();
  static Widget iGaveBirthScreen = const IGabeBirthScreen();
  static Widget loginScreen = const LoginScreen();
  static Widget loginSecondScreen = const LoginSecondScreen();
  static Widget mainScreen = const MainScreen();
  static Widget mastersScreen = const MastersScreen();
  static Widget movementCounterScreen = const MovementCounterScreen();
  static Widget myWeightScreen = const MyWeightScreen();
  static Widget paywallScreen = const PaywallScreen();
  static Widget savedArticlesScreen = const SavedArticlesScreen();
  static Widget selectTimeScreen = const SelectTimeScreen();
  static Widget settingsScreen = const SettingsScreen();
  static Widget shoppingListScreen = const ShoppingPlanScreen();
  static Widget splashScreen = const SplashScreen();
  static Widget tummySizeScreen = const TummySizeScreen();
  static Widget yesNoAttentionScreen = const YesNoAttentionScreen();
  static Widget weeklyAdviceViewScreen = const WeeklyAdviceViewScreen();

  static List<Bindings> mainBindings = [
    MainBinding(),
    HomeBinding(),
    CalendarBinding(),
    MastersBinding(),
    SettingsBinding(),
  ];

  static List<GetPage> pages = [
    GetPage(name: addDoctor, page: () => addDoctorScreen, binding: AddNoteAndDoctorBinding()),
    GetPage(name: addMedicament, page: () => addMedicamentScreen, binding: AddMedicamentBinding()),
    GetPage(name: addMovement, page: () => addMovementScreen, binding: AddMovementBinding()),
    GetPage(name: addNote, page: () => addNoteScreen, binding: AddNoteAndDoctorBinding()),
    GetPage(name: articleView, page: () => articleViewScreen, binding: ArticleViewBinding()),
    GetPage(name: calendar, page: () => calendarScreen, binding: CalendarBinding()),
    GetPage(name: canOrCant, page: () => canOrCantScreen, binding: CanOrCantBinding()),
    GetPage(name: chooseName, page: () => chooseNameScreen, binding: ChooseNameBinding()),
    GetPage(name: contractionCounter, page: () => contractionCounterScreen, binding: ContractionCounterBinding()),
    GetPage(name: dailyAdviceView, page: () => dailyAdviceViewScreen, binding: DailyAdviceViewBinding()),
    GetPage(name: hospitalBag, page: () => hospitalBagScreen, binding: HospitalBagBinding()),
    GetPage(name: iGaveBirth, page: () => iGaveBirthScreen, binding: IGabeBirthBinding()),
    GetPage(name: login, page: () => loginScreen, binding: LoginBinding()),
    GetPage(name: loginSecond, page: () => loginSecondScreen, binding: LoginSecondBinding()),
    GetPage(name: main, page: () => mainScreen, bindings: mainBindings),
    GetPage(name: masters, page: () => mastersScreen, binding: MastersBinding()),
    GetPage(name: myWeight, page: () => myWeightScreen, binding: MyWeightBinding()),
    GetPage(name: movementCounter, page: () => movementCounterScreen, binding: MovementCounterBinding()),
    GetPage(name: paywall, page: () => paywallScreen, binding: PaywallBinding()),
    GetPage(name: savedArticles, page: () => savedArticlesScreen, binding: SavedArticlesBinding()),
    GetPage(name: selectTime, page: () => selectTimeScreen, binding: SelectTimeBinding()),
    GetPage(name: settings, page: () => settingsScreen, binding: SettingsBinding()),
    GetPage(name: shoppingList, page: () => shoppingListScreen, binding: ShoppingPlanBinding()),
    GetPage(name: splash, page: () => splashScreen, binding: SplashBinding()),
    GetPage(name: tummySize, page: () => tummySizeScreen, binding: TummySizeBinding()),
    GetPage(name: yesNoAttention, page: () => yesNoAttentionScreen, binding: YesNoAttentionBinding()),
    GetPage(name: weeklyAdviceView, page: () => weeklyAdviceViewScreen, binding: WeeklyAdviceViewBinding()),
  ];
}
