import 'package:dio/dio.dart'hide Headers;
import 'package:flutter_pom/api/models/InitResponseModel.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient{
  factory APIClient(Dio dio) = _APIClient;


  @POST("identity/api/v1/web/initialize")
  Future<InitResponseModel> initializeService(@Body() RequestPayloadModel requestPayloadModel);

  @GET("identity/api/v1/keys/mle")
  Future<dynamic> getMLE();

}