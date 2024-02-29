// To parse this JSON data, do
//
//     final initResponseModel = initResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InitResponseModel initResponseModelFromJson(String str) => InitResponseModel.fromJson(json.decode(str));

String initResponseModelToJson(InitResponseModel data) => json.encode(data.toJson());

class InitResponseModel {
  String responseCode;
  String responseMessage;
  String callbackUrl;
  int id;
  int instid;
  String uuid;

  InitResponseModel({
    required this.responseCode,
    required this.responseMessage,
    required this.callbackUrl,
    required this.id,
    required this.instid,
    required this.uuid,
  });

  factory InitResponseModel.fromJson(Map<String, dynamic> json) => InitResponseModel(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    callbackUrl: json["callbackUrl"],
    id: json["id"],
    instid: json["instid"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "callbackUrl": callbackUrl,
    "id": id,
    "instid": instid,
    "uuid": uuid,
  };
}
