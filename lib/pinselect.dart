import 'package:flutter/cupertino.dart';
import 'package:flutter_pom/utils/mqtt_manager.dart';

import 'models/Urls.dart';

class PinSelect {
  late bool live;
  Urls urls = Urls(pomBaseUrl: 'https://testids.interswitch.co.ke/',
      mqttBaseUrl: 'testmerchant.interswitch-ke.com');

  PinSelect({required this.live}) {
    live = live;
    if (live) {
      Urls liveUrls = Urls(pomBaseUrl: 'https://testids.interswitch.co.ke/',
          mqttBaseUrl: 'merchant.interswitch-ke.com');
      urls = liveUrls;
    }
  }

  Future<void> changePin({required BuildContext context, required String pomUrl, required String uuid, required Function(Map<String, dynamic>) transactionSuccessfulCallback,
    required Function(Map<String, dynamic>) transactionFailureCallback,}) async {
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
