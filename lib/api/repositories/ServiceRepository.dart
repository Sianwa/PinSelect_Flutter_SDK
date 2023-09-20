import 'package:dio/dio.dart';
import 'package:flutter_pom/api/client.dart';
import 'package:flutter_pom/api/dio_exceptions.dart';

class ServiceRepository{
  final client = Client.init();

  ServiceRepository();


  Future<dynamic> initializeService() async{
    try{
      var resp = await client.initializeService();
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