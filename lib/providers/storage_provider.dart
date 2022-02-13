import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:pregnancy_tracker_tm/utils/util_storage.dart';

class StorageProvider extends GetxService {
  Future<StorageProvider> init() async {
    await GetStorage.init();
    if(box.read(UtilStorage.firstRun) == null) {
      MetricaPlugin.reportEvent('install_app');
    }
    return this;
  }

  GetStorage get box => GetStorage();
}
