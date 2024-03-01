import 'package:dio/dio.dart'hide Headers;
import 'package:flutter_pom/api/models/InitResponseModel.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient{
  factory APIClient(Dio dio) = _APIClient;


  @Headers({"InstID": "54",
    "Nonce": "d180fa188a9548139d5ab69b3438db72",
    "Timestamp": "1709280789113",
    "SignatureMethod": "SHA1",
    "Signature": "SiYdARRXG2AO15Z8wxwvd4gx1mU=",
    "Authorization": "InterswitchAuth SUtJQTk3MUZCNTk5NkVBREJEMTY1MzQ0OTRDQjg3QjkwRDFEQjNFQUQxMDU="})
  @POST("identity/api/v1/web/initialize")
  Future<InitResponseModel> initializeService(@Body() RequestPayloadModel requestPayloadModel);

  @GET("identity/api/v1/keys/mle")
  Future<dynamic> getMLE();

}