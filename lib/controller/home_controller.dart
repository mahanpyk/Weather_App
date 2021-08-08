import 'package:flutter_projects/api/api_setting.dart';
import 'package:flutter_projects/models/weather.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var weatherList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getWeather();
  }

  void getWeather() {
    ApiSetting apiCall = ApiSetting();
    apiCall.getRequest(q: 'tehran').then((value) {
      if (value.success != null) {
        bool success = value.success ?? false;
        if (success) {
          weatherList.add(setWeather(value.body));
          print(weatherList.toSet());
        } else {
          throw 'response is not valid';
        }
      } else {
        throw 'request failed';
      }
      update();
    });
  }
}
