import 'package:dio/dio.dart';
import 'package:flutter_projects/models/response.dart';

class ApiSetting {
  final Dio _dio = Dio();

  Future<ResponseModel> getRequest({String? q}) async {
    return _dio
        .get(
      'https://api.weatherapi.com/v1/current.json',
      queryParameters: {
        'key': '9893f5dd50894ff0b5173354210808',
        'q': q == null ? '' : q,
        'aqi': 'no',
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
      ),
    )
        .then((value) {
      ResponseModel responseModel = ResponseModel(
        value.statusCode == 200,
        value.statusCode,
        value.data,
      );
      return responseModel;
    }).catchError((e, s) {
      throw 'Connection Error';
    });
  }
}
