import 'package:dio/dio.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient{
  factory APIClient(Dio dio) = _APIClient;

  @POST("identity/api/v1/web/initialize")
  Future<dynamic> initializeService(@Body() RequestPayloadModel requestPayloadModel);

  @GET("identity/api/v1/keys/mle")
  Future<dynamic> getMLE();

}