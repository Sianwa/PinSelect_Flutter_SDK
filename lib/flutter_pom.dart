library flutter_pom;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final Function(Map<String, dynamic>) transactionSuccessfulCallback;
  final Function(Map<String, dynamic>) transactionFailureCallback;
  const WebViewExample(
      {Key? key,
      required this.url,
      required this.transactionSuccessfulCallback,
      required this.transactionFailureCallback})
      : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState(
      url, transactionSuccessfulCallback, transactionFailureCallback);
}

class WebViewExampleState extends State<WebViewExample> {
  final String url;
  final Function(Map<String, dynamic>) transactionSuccessfullCallback;
  final Function(Map<String, dynamic>) transactionFailureCallback;
  late final WebViewController _controller;

  WebViewExampleState(this.url, this.transactionSuccessfullCallback,
      this.transactionFailureCallback);
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _interceptNavigation,
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }

  NavigationDecision _interceptNavigation(NavigationRequest request) {
    //check if it has the good old response
    if (request.url.contains("response")) {
      var uri = Uri.dataFromString(request.url);
      var response = uri.queryParameters['response'];
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String decoded = stringToBase64.decode(response!);
      var jsonResponse = jsonDecode(decoded);
      Navigator.maybePop(context);
      if (jsonResponse['responseCode'] == "00" ||
          jsonResponse['responseCode'] == "0") {
        transactionSuccessfullCallback(jsonResponse);
      } else {
        transactionFailureCallback(jsonResponse);
      }
      //check if the response is either a success or a failure
    }
    return NavigationDecision.navigate;
  }
}
