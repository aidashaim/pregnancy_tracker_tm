import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

String urlApi = 'https://pregancytracker.com/wp-json/raten/v1/';
String language = 'ru';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    timeout = const Duration(seconds: 40);
    httpClient.baseUrl = urlApi;
    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      return request;
    });
  }
}
