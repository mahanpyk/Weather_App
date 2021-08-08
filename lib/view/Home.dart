import 'package:flutter/material.dart';
import 'package:flutter_projects/controller/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Weather App',
          style: TextStyle(
            fontFamily: 'IRANSans',
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: GetBuilder<HomeController>(builder: (c) {
        return _controller.weatherList.length == 0
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
                            fontFamily: 'IRANSans',
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
                    itemCount: _controller.weatherList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return generateItem(_controller.weatherList[index]);
                    }),
              );
      }),
    );
  }

  Widget generateItem(currency) {
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
              color: currency.changeStatus == "+" ? Colors.green : Colors.red,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Container(
                height: 48,
                child: Row(children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: currency.changeStatus == "+"
                        ? Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Wrap(children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${currency.changePercent.toString()} \%',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IRANSans',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Wrap(children: [
                      Text(
                        currency.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Wrap(children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'IRANSans',
                            fontSize: 14,
                            color: currency.changeStatus == "+"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Wrap(children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " ريال",
                          style: TextStyle(
                            fontFamily: 'IRANSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
