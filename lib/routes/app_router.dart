import 'package:flutter_projects/view/Home.dart';
import 'package:get/get.dart';

class AppRouter {
  static final route = [
    GetPage(name: '/home', page: () => Home()),
  ];
}
