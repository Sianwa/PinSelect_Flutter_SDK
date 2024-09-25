import 'package:flutter/cupertino.dart';
import 'package:flutter_pom/api/models/AccountModel.dart';
import 'package:flutter_pom/api/models/InitResponseModel.dart';
import 'package:flutter_pom/api/models/InstitutionModel.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';
import 'package:flutter_pom/api/repositories/ServiceRepository.dart';
import 'package:flutter_pom/utils/header_generation.dart';
import 'package:flutter_pom/utils/mqtt_manager.dart';

import 'models/Urls.dart';

class PinSelect {
  late bool live;
  HeaderGenerator headerGenerator = HeaderGenerator();
  late ServiceRepository serviceRepository;

  Urls urls = Urls(
      pomBaseUrl: 'http://pin-on-mobile-tests.test.kube.iswke/',
      mqttBaseUrl: 'testmerchant.interswitch-ke.com');

  PinSelect({required this.live}) {
    live = live;
    if (live) {
      Urls liveUrls = Urls(
          pomBaseUrl: 'https://esb.interswitch.co.ke/',
          mqttBaseUrl: 'merchant.interswitch-ke.com');
      urls = liveUrls;
    }
  }

  Future<dynamic> initialize({required AccountModel accountModel, required InstitutionModel institutionModel}) async {
    try {
      //generate headers
      var headers = headerGenerator.generateHeaders(
          institutionModel.institutionId.toString(),
          institutionModel.clientId,
          institutionModel.clientSecret,
          "POST",
          "/identity/api/v1/");

      serviceRepository = ServiceRepository(headers);

      var resp = await serviceRepository.initializeService(RequestPayloadModel(
          account: Account(
              cardSerialNumber: accountModel.cardSerNo,
              isDebit: accountModel.isDebit),
          institution: Institution(
              callbackUrl: institutionModel.callbackURL,
              id: institutionModel.institutionId)));
      return resp;

    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePin({
    required BuildContext context,
    required String pomUrl,
    required String uuid,
    required Function(Map<String, dynamic>) transactionSuccessfulCallback,
    required Function(Map<String, dynamic>) transactionFailureCallback,
  }) async {
    try {
      MQTTManager mqttManager = MQTTManager(
          context: context,
          uuid: uuid,
          transactionSuccessfulCallback: transactionSuccessfulCallback,
          transactionFailureCallback: transactionFailureCallback);

      mqttManager.initializeMQTTClient(urls);
      mqttManager.launchWebView(pomUrl, context);
    } catch (e) {
      rethrow;
    }
  }
}
