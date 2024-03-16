import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true),
    );
  }

  //static to can call it DioHelper.getdata
  static Future<Response?> getData(
      {required String url, //positional path(endPoint(method))
      required Map<String, dynamic> query}) //query(map)
  async {
    return dio?.get(url, queryParameters: query);
  }
}
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cb9339b8c436452387f42535e3047564