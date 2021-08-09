import 'package:flutter/material.dart';
import 'package:flutter_projects/api/api_setting.dart';
import 'package:flutter_projects/models/response.dart';
import 'package:flutter_projects/models/weather.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var weatherList = [].obs;
  List secondWeatherList = [];
  List qList = [
    'tehran',
    'landon',
    'Paris',
    'Canada',
    'USA',
    'spanish',
    'madrid',
    'Veneto',
    'Rome',
    'Germantown',
    'New Delhi'
  ];

  TextEditingController? searchController;
  var search = false.obs;

  @override
  void onInit() {
    searchController = TextEditingController();
    super.onInit();
    qList.forEach((element) {
      getWeather(element);
    });
  }

  searchAction(String textInput) {
    List resultList = [];
    if (textInput.length >= 2) {
      weatherList.forEach((element) {
        if (element.name.toLowerCase().contains(textInput) ||
            element.region.toLowerCase().contains(textInput) ||
            element.country.toLowerCase().contains(textInput)) {
          resultList.add(element);
        }
      });
      if (resultList.length > 0) {
        weatherList.clear();
        weatherList.addAll(resultList);
        update();
      } else {

      }
    } else {
      weatherList.clear();
      weatherList.addAll(secondWeatherList);
      update();
    }
  }

  void getWeather(String q) async {
    ApiSetting apiCall = ApiSetting();
    ResponseModel response = await apiCall.getRequest(q: q);
    if (response.success != null) {
      bool success = response.success ?? false;
      if (success) {
        weatherList.add(setWeather(response.body));
        secondWeatherList.clear();
        secondWeatherList.addAll(weatherList);
      } else {
        throw 'response is not valid';
      }
    } else {
      throw 'request failed';
    }
    update();
  }

  @override
  void onClose() {
    searchController!.dispose();
    super.onClose();
  }

  onPressSearch() {
    search(!search.value);
  }
}
