// To parse this JSON data, do
//
//     final requestPayloadModel = requestPayloadModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RequestPayloadModel requestPayloadModelFromJson(String str) => RequestPayloadModel.fromJson(json.decode(str));

String requestPayloadModelToJson(RequestPayloadModel data) => json.encode(data.toJson());

class RequestPayloadModel {
  Account account;
  Institution institution;

  RequestPayloadModel({
    required this.account,
    required this.institution,
  });

  factory RequestPayloadModel.fromJson(Map<String, dynamic> json) => RequestPayloadModel(
    account: Account.fromJson(json["account"]),
    institution: Institution.fromJson(json["institution"]),
  );

  Map<String, dynamic> toJson() => {
    "account": account.toJson(),
    "institution": institution.toJson(),
  };
}

class Account {
  String cardSerialNumber;
  bool isDebit;

  Account({
    required this.cardSerialNumber,
    required this.isDebit,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    cardSerialNumber: json["cardSerialNumber"],
    isDebit: json["isDebit"],
  );

  Map<String, dynamic> toJson() => {
    "cardSerialNumber": cardSerialNumber,
    "isDebit": isDebit,
  };
}

class Institution {
  String callbackUrl;
  int id;

  Institution({
    required this.callbackUrl,
    required this.id,
  });

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
    callbackUrl: json["callbackUrl"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "callbackUrl": callbackUrl,
    "id": id,
  };
}
