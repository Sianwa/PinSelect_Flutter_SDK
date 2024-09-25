import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pom/api/client.dart';
import 'package:flutter_pom/api/models/InitResponseModel.dart';
import 'package:flutter_pom/api/utils/dio_exceptions.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';


class ServiceRepository{
  ServiceRepository(this.authHeaders);
  final Map<String, String> authHeaders;


  Future<dynamic> initializeService(String baseURL, RequestPayloadModel requestPayloadModel) async{
    try{
      final client = Client.init(authHeaders, baseURL);
      var resp = await client.initializeService(requestPayloadModel);
      debugPrint("INITIALIZE RESP::${initResponseModelToJson(resp)}");
      return resp;
    } on DioError catch(e){
      final errorMsg = DioExceptions.fromDioError(e).toString();
    }
  }
}