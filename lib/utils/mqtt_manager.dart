import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pom/models/Urls.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../flutter_pom.dart';

class MQTTManager {
  late BuildContext context;
  late final MqttServerClient client;
  late final String uuid;
  Function(Map<String, dynamic>) transactionSuccessfulCallback;
  Function(Map<String, dynamic>) transactionFailureCallback;
  MQTTManager({required this.context,
    required this.uuid,
    required this.transactionSuccessfulCallback,
    required this.transactionFailureCallback});

  void initializeMQTTClient(Urls urls) async {
    context = context;
    client = MqttServerClient(urls.mqttBaseUrl, '');
    client.logging(on: true);
    client.keepAlivePeriod = 10;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.onDisconnected = _onDisconnected;

    final MqttConnectMessage connectMessage = MqttConnectMessage()
        .withClientIdentifier(DateTime.now().millisecondsSinceEpoch.toString())
        .withWillTopic('willTopic')
        .withWillMessage('Node has left the chat')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connectMessage;

    try {
      await client.connect();
    }
    on Exception catch (e) {
      debugPrint('MQTT::client exception - $e');
      client.disconnect();
      rethrow;
    }
  }

  void _onConnected(){
    debugPrint("MQTT::CONNECTED");

    //subscribe to topic
    var transactionTopic = "identity/$uuid";
    client.subscribe(transactionTopic, MqttQos.atMostOnce);

    client.published!.listen((MqttPublishMessage message) {
      debugPrint("MQTT::MESSAGE RECEIVED :: ${message.payload.message}");
      Map<String, dynamic> mqttPayload = json.decode(MqttPublishPayload.bytesToStringAsString(message.payload.message));
      debugPrint("MQTT::MESSAGE RECEIVED :: ${mqttPayload.toString()}");
      client.disconnect();

      if (mqttPayload['responseCode'] == "00" || mqttPayload['responseCode'] == "0") {
        transactionSuccessfulCallback(mqttPayload);
      }
      else {
        transactionFailureCallback(mqttPayload);
      }
    });

  }

  void _onSubscribed(String topic) {
    debugPrint('MQTT::Subscription confirmed for topic $topic');
  }

  void _onDisconnected() {
    Navigator.maybePop(context);
    debugPrint('MQTT::OnDisconnected client callback - Client disconnection');
  }

  Future<void> launchWebView(String url, BuildContext context) async {
    Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewExample(
                    url: url,
                    transactionSuccessfulCallback: transactionSuccessfulCallback,
                    transactionFailureCallback: transactionFailureCallback,
                  )),
        );
      }
    } else {
      debugPrint("URL ERROR:: Cannot launch url -> $url");
      throw 'Could not lunch $url';
    }
  }
}
