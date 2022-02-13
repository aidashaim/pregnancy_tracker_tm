import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/repositories/daily_advice_repository.dart';
import 'package:pregnancy_tracker_tm/services/api_service.dart';
import 'package:pregnancy_tracker_tm/widgets/grid_item.dart';
import 'package:pregnancy_tracker_tm/utils/util_icons.dart';
import 'package:pregnancy_tracker_tm/utils/util_routes.dart';

class CanOrCantController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final RxBool isLoading = false.obs;

  final List<List<CanOrCantModel>> canOrCants = [];
  final List<String> _types = ['house', 'health', 'beauty', 'food', 'travel', 'sex', 'dream', 'fitness'];

  List<GridItem> gridItems = [];

  @override
  void onInit() {
    getCanOrCants();
    addItemsToList();
    super.onInit();
  }

  Future<void> getCanOrCants() async {
    isLoading.value = true;
    for (var type in _types) {
      final Response response = await _apiService.getCanOrCant(type: type);
      if (response.isOk && response.body != null) {
        List<CanOrCantModel> _list = [...response.body];
        await Future.forEach(_list, (item) async {
          (item as CanOrCantModel).type = type;
          item.isSaved =
              dailyAdviceRepository.articles.firstWhereOrNull((e) => e == '${item.type}/${item.title}/ru') != null;
        });
        canOrCants.add(_list);
      }
    }
    isLoading.value = false;
  }

  void onCanOrCantTap(int index, String title) {
    Get.toNamed(UtilRoutes.yesNoAttention, arguments: {'canOrCants': canOrCants[index], 'title': title});
  }

  void addItemsToList() {
    gridItems
      ..clear()
      ..addAll([
        GridItem(title: 'Дом и работа', onTap: () => onCanOrCantTap(0, 'Дом и работа'), icon: UtilIcons.house),
        GridItem(title: 'Здоровье', onTap: () => onCanOrCantTap(1, 'Здоровье'), icon: UtilIcons.food),
        GridItem(title: 'Красота', onTap: () => onCanOrCantTap(2, 'Красота'), icon: UtilIcons.beauty),
        GridItem(title: 'Питание', onTap: () => onCanOrCantTap(3, 'Питание'), icon: UtilIcons.mastersPermitted),
        GridItem(title: 'Путешествия', onTap: () => onCanOrCantTap(4, 'Путешествия'), icon: UtilIcons.ship),
        GridItem(title: 'Секс', onTap: () => onCanOrCantTap(5, 'Секс'), icon: UtilIcons.sex),
        GridItem(title: 'Сон', onTap: () => onCanOrCantTap(6, 'Сон'), icon: UtilIcons.bed),
        GridItem(title: 'Фитнес', onTap: () => onCanOrCantTap(7, 'Фитнес'), icon: UtilIcons.fitness),
      ]);
  }
}
