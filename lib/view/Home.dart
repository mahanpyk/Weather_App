import 'package:flutter/material.dart';
import 'package:flutter_projects/controller/home_controller.dart';
import 'package:flutter_projects/models/weather.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Obx(
          () => _controller.search.value
              ? TextField(
                  maxLength: 24,
                  onChanged: (String value) => _controller.searchAction(value),
                  controller: _controller.searchController,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    counterText: ''
                  ),
                )
              : Text(
                  'Weather App',
                ),
        ),
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () =>_controller.onPressSearch(),
          icon: Obx(
            () => Icon(_controller.search.value ? Icons.close : Icons.search),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(builder: (c) {
        return _controller.weatherList.length < 1
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.red),
                      SizedBox(height: 16),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "در حال دریافت اطلاعات ... ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.weatherList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return weatherItem(_controller.weatherList[index]);
                    }),
              );
      }),
    );
  }

  Widget weatherItem(WeatherModel weather) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              height: 48,
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Wrap(children: [
                    Text(
                      weather.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: Wrap(children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Image.network(
                          '${weather.icon}',
                          width: 24,
                          height: 24,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${weather.tempC.toString()} C',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
