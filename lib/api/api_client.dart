import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient{
  factory APIClient(Dio dio) = _APIClient;

  //todo: create endpoints
  @POST("identity/api/v1/web/initialize")
  Future<dynamic> initializeService();

  @GET("identity/api/v1/keys/mle")
  Future<dynamic> getMLE();

}