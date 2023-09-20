import 'package:dio/dio.dart';

import 'api_client.dart';

class Client{
  static APIClient init(){

    Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://testids.interswitch.co.ke/",
        connectTimeout: 120000,
        receiveTimeout: 120000
      )
    );

    return APIClient(dio);
  }
}