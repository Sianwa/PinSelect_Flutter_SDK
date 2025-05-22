import 'package:dio/dio.dart';
import 'package:flutter_pom/api/utils/auth_interceptor.dart';
import 'package:flutter_pom/utils/header_generation.dart';

import 'api_client.dart';

class Client{
  static APIClient init(Map<String, String> authHeaders, String baseURL){

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout:const Duration(milliseconds: 120000),
        receiveTimeout: const Duration(milliseconds: 120000),
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