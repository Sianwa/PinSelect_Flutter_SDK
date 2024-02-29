import 'package:dio/dio.dart';
import 'package:flutter_pom/api/client.dart';
import 'package:flutter_pom/api/dio_exceptions.dart';
import 'package:flutter_pom/api/models/AccountModel.dart';
import 'package:flutter_pom/api/models/InstitutionModel.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';


class ServiceRepository{
  final client = Client.init();

  ServiceRepository();

  Future<dynamic> initializeService(RequestPayloadModel requestPayloadModel) async{
    try{
      var resp = await client.initializeService(requestPayloadModel);
      return resp;

    } on DioError catch(e){
      final errorMsg = DioExceptions.fromDioError(e).toString();
    }
  }

  Future<dynamic>? getMLE() async{
    try{
      var resp = await client.getMLE();
      return resp;

    } on DioError catch(e){
      final errorMsg = DioExceptions.fromDioError(e).toString();
    }
  }

}