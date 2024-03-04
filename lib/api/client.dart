import 'package:dio/dio.dart';
import 'package:flutter_pom/api/utils/auth_interceptor.dart';
import 'package:flutter_pom/utils/header_generation.dart';

import 'api_client.dart';

class Client{
  static APIClient init(Map<String, String> authHeaders){

    Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://testids.interswitch.co.ke/",
        connectTimeout: 120000,
        receiveTimeout: 120000
      )
    );

    //Add an interceptor to add auth headers
    dio.interceptors.add(AuthInterceptor(authHeaders));

    // Add an interceptor to log requests and responses
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      responseHeader: true,
    ));



    return APIClient(dio);
  }
}