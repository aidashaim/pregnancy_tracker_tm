import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/models/weekly_advice_model.dart';
import 'package:pregnancy_tracker_tm/providers/api_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_endpoints.dart';

class ApiService extends GetxService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<Response<WeeklyAdviceModel>> getWeeklyAdviceBaby({required int week}) async => _apiProvider.get(
        UtilEndpoints.weeklyAdviceBaby(week),
        decoder: (data) => WeeklyAdviceModel.fromJSON(data as Map<String, dynamic>),
      );

  Future<Response<WeeklyAdviceModel>> getWeeklyAdviceMom({required int week}) async => _apiProvider.get(
        UtilEndpoints.weeklyAdviceMom(week),
        decoder: (data) => WeeklyAdviceModel.fromJSON(data as Map<String, dynamic>),
      );

  Future<Response<WeeklyAdviceModel>> getWeeklyAdviceGeneral({required int week}) async => _apiProvider.get(
        UtilEndpoints.weeklyAdviceGeneral(week),
        decoder: (data) => WeeklyAdviceModel.fromJSON(data as Map<String, dynamic>),
      );

  Future<Response<DailyAdviceModel?>> getDailyAdvices({required int day}) async => _apiProvider.get(
        UtilEndpoints.dailyAdvice(day),
        decoder: (data) => data is Map<String, dynamic> ? DailyAdviceModel.fromJSON(data) : null,
      );

  Future<Response<Iterable<CanOrCantModel>>> getCanOrCant({required String type}) async => _apiProvider.get(
        UtilEndpoints.canOrCant(type),
        decoder: (data) => data is List
            ? data.map(
                (advice) => CanOrCantModel.fromJSON(advice as Map<String, dynamic>),
              )
            : [],
      );
}
