import 'package:flutter/material.dart';
import 'package:flutter_projects/routes/app_router.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.route,
      initialRoute: '/home',
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    ),
  );
}
