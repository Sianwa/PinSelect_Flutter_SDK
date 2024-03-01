import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pom/api/client.dart';
import 'package:flutter_pom/api/models/InitResponseModel.dart';
import 'package:flutter_pom/api/utils/dio_exceptions.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';


class ServiceRepository{
  ServiceRepository();
  final client = Client.init();

  Future<dynamic> initializeService(RequestPayloadModel requestPayloadModel) async{
    try{
      var resp = await client.initializeService(requestPayloadModel);
      debugPrint("INITIALIZE RESP:: ");
      return initResponseModelToJson(resp);
    } on DioError catch(e){
      final errorMsg = DioExceptions.fromDioError(e).toString();
    }
  }

  @deprecated
  Future<dynamic>? getMLE() async{
    try{
      var resp = await client.getMLE();
      return resp;

    } on DioError catch(e){
      final errorMsg = DioExceptions.fromDioError(e).toString();
    }
  }

}