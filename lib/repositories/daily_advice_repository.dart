import 'package:get/get.dart';
import 'package:pregnancy_tracker_tm/models/can_or_cant_model.dart';
import 'package:pregnancy_tracker_tm/models/daily_advice_model.dart';
import 'package:pregnancy_tracker_tm/providers/storage_provider.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class DailyAdviceRepository {
  final StorageProvider _storage = Get.find<StorageProvider>();
  List<String> dailyAdvices = [];
  List<String> articles = [];

  void onInit() {
    Future.wait([getDailyAdvices(), getArticles()]);
  }

  Future<void> addDailyAdvice({required DailyAdviceModel dailyAdvice}) async {
    if (dailyAdvice.isSaved) {
      dailyAdvices.remove('${dailyAdvice.day.toString()}/ru');
    } else {
      dailyAdvices.add('${dailyAdvice.day.toString()}/ru');
    }
    await _storage.box.write(UtilStorage.dailyAdvicesItems, dailyAdvices);
  }

  Future<void> addArticle({required CanOrCantModel article}) async {
    if (article.isSaved) {
      articles.remove('${article.type}/${article.title.toString()}/ru');
    } else {
      articles.add('${article.type}/${article.title}/ru');
    }
    await _storage.box.write(UtilStorage.savedArticles, articles);
  }

  Future<void> getDailyAdvices() async {
    final List dailyAdvicesItems = _storage.box.read(UtilStorage.dailyAdvicesItems) as List? ?? [];
    dailyAdvices.clear();
    await Future.forEach(dailyAdvicesItems, (item) {
      dailyAdvices.add(item as String);
    });
    await _storage.box.write(UtilStorage.dailyAdvicesItems, dailyAdvices);
  }

  Future<void> getArticles() async {
    final List articlesItems = _storage.box.read(UtilStorage.savedArticles) as List? ?? [];
    articles.clear();
    await Future.forEach(articlesItems, (item) {
      articles.add(item as String);
    });
    await _storage.box.write(UtilStorage.savedArticles, articles);
  }
}

DailyAdviceRepository dailyAdviceRepository = DailyAdviceRepository();
