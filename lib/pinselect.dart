import 'package:flutter/cupertino.dart';
import 'package:flutter_pom/api/models/AccountModel.dart';
import 'package:flutter_pom/api/models/InstitutionModel.dart';
import 'package:flutter_pom/api/models/RequestPayloadModel.dart';
import 'package:flutter_pom/api/repositories/ServiceRepository.dart';
import 'package:flutter_pom/utils/header_generation.dart';
import 'package:flutter_pom/utils/mqtt_manager.dart';

import 'models/Urls.dart';

class PinSelect {
  late bool live;
  HeaderGenerator headerGenerator = HeaderGenerator();
  ServiceRepository serviceRepository = ServiceRepository();

  Urls urls = Urls(
      pomBaseUrl: 'https://testids.interswitch.co.ke/',
      mqttBaseUrl: 'testmerchant.interswitch-ke.com');

  PinSelect({required this.live}) {
    live = live;
    if (live) {
      Urls liveUrls = Urls(
          pomBaseUrl: 'https://testids.interswitch.co.ke/',
          mqttBaseUrl: 'merchant.interswitch-ke.com');
      urls = liveUrls;
    }
  }

  Future<void> initialize(
      {required AccountModel accountModel,
      required InstitutionModel institutionModel}) async {
    try {
      //generate headers
      var headers = headerGenerator.generateHeaders(
          institutionModel.institutionId.toString(),
          institutionModel.clientId,
          institutionModel.clientSecret,
          "${urls.pomBaseUrl}identity/api/v1/web/initialize",
          "");

      var resp = serviceRepository.initializeService(RequestPayloadModel(account: Account(cardSerialNumber: accountModel.cardSerNo, isDebit: accountModel.isDebit),
          institution: Institution(callbackUrl: institutionModel.callbackURL, instId: institutionModel.institutionId))
      );

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
